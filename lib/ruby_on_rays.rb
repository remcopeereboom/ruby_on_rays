require 'ruby_on_rays/version'
require 'ruby_on_rays/vector2'
require 'ruby_on_rays/point2'
require 'ruby_on_rays/vector3'
require 'ruby_on_rays/point3'
require 'ruby_on_rays/normal3'
require 'ruby_on_rays/ray3'
require 'ruby_on_rays/matrix4x4'
require 'ruby_on_rays/transform'
require 'ruby_on_rays/color'

# RubyOnRays
#
# Top-level namespace for the Ruby on Rays program.
module RubyOnRays
  require 'chunky_png'

  # Runner for bin/run.
  def self.run
    width = 480
    height = 480

    camera_rays = {}

    dx = 2.0 / width
    dy = 2.0 / height
    offset_x = -1.0 + 0.5 * dx
    offset_y = -1.0 + 0.5 * dy

    (0...height).each do |y|
      (0...width).each do |x|
        z_viewplane = 1.0

        o = Point3.origin
        d = Vector3.new(offset_x + x * dx, offset_y + y * dy, z_viewplane)
        ray = Ray3.new(o, d)

        p_film = {x: x, y: y}

        camera_rays[p_film] = ray
      end
    end

    sphere = Sphere.new(color: Color.new(1.0, 0.0, 0.0))
    light = Point3.new(10.0, 10.0, -10.0)

    film = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)
    camera_rays.each do |p_film, ray|
      if hitinfo = sphere.intersection(ray)
        l = light.sub(hitinfo[:p]).normalize
        diffuse = hitinfo[:n].dot(l)
        diffuse = 0 if diffuse < 0

        kd = 0.9 # diffuse factor
        ka = 0.1 # ambient factor
        r = ((kd * diffuse + ka) * sphere.color.r * 255).to_i
        g = ((kd * diffuse + ka) * sphere.color.g * 255).to_i
        b = ((kd * diffuse + ka) * sphere.color.b * 255).to_i

        film[p_film[:x], height - p_film[:y]] = ChunkyPNG::Color.rgb(r, g, b)
      end
    end

    previous_name = Dir.glob('./tmp/foo*.png').last
    previous_index = previous_name.match(/foo(\d?)\.png/)[1].to_i
    next_name = "tmp/foo#{previous_index + 1}.png"
    film.save(next_name)
  end

  class Sphere
    attr_reader :color

    def initialize(center: Point3.new(0.0, 0.0, 2.0),
                   radius: 1.0,
                   color: Color.new(rand, rand, rand))
      @center = center
      @radius = radius
      @color  = color
    end

    def intersection(ray)
      a = ray.d.dot(ray.d)
      b = 2.0 * ray.d.dot(ray.o.sub(@center))
      c = @center.dot(@center) - 2.0 * @center.dot(ray.o) - @radius**2

      d2  = b**2 - 4 * a * c
      return false unless d2 > 0

      t0 = (-b - Math.sqrt(d2)) / (2 * a)
      t1 = (-b + Math.sqrt(d2)) / (2 * a)

      t0, t1 = t1, t0 if t0 > t1
      return false if t1 < ray.tmin || t0 > ray.tmax

      t_hit = t0
      if t_hit < ray.tmin
        t_hit = t1
        return false if t_hit > ray.tmax
      end

      p_hit = ray[t_hit]
      n_hit = (p_hit.sub(@center).div @radius).to_n

      { t: t_hit, p: p_hit, n: n_hit }
    end
  end
end
