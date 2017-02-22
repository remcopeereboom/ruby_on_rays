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

require 'ruby_on_rays/scene'
require 'ruby_on_rays/sphere'
require 'ruby_on_rays/point_light'
require 'ruby_on_rays/perspective_camera'

# RubyOnRays
#
# Top-level namespace for the Ruby on Rays program.
module RubyOnRays
  require 'chunky_png'

  # Runner for bin/run.
  def self.run
    width = 480
    height = 480

    scene = self.scene()
    camera = PerspectiveCamera.new(width, height)

    camera.each_sample_with_ray do |p_film, ray|
      hit_info = trace(ray, scene)
      next unless hit_info

      camera[p_film] = hit_to_color(hit_info, scene.lights.first)
    end

    camera.save
  end

  # Find the nearest collision with a ray.
  # @param ray [Ray3] The ray to trace.
  # @return [HitInfo]
  def self.trace(ray, scene)
    hit_info = nil
    scene.shapes.each do |shape|
      local_hit_info = shape.intersection(ray)

      if local_hit_info
        hit_info = local_hit_info
        ray.tmax = hit_info[:t]
      end
    end

    hit_info
  end

  # Returns a simple scene.
  # @return [Scene]
  def self.scene
    scene = Scene.new
    scene.add_shape(Sphere.new(center: Point3.new(0.0, 0.0, 2.0), radius: 1.0))
    scene.add_shape(Sphere.new(center: Point3.new(0.0, 1.0, 3.0), radius: 1.0))
    scene.add_light(PointLight.new(Point3.new(10.0, 10.0, -10.0)))
    scene
  end

  def self.hit_to_color(hit_info, light)
    l = light.p.sub(hit_info[:p]).normalize

    diffuse = hit_info[:n].dot(l)
    diffuse = 0 if diffuse < 0

    kd = 0.9 # diffuse factor
    ka = 0.1 # ambient factor
    hit_info[:shape].color.mul(kd * diffuse + ka)
  end
end
