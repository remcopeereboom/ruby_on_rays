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
require 'ruby_on_rays/shapes/sphere'
require 'ruby_on_rays/shapes/plane'
require 'ruby_on_rays/point_light'
require 'ruby_on_rays/perspective_camera'

# RubyOnRays
#
# Top-level namespace for the Ruby on Rays program.
module RubyOnRays
  require 'chunky_png'

  # Runner for bin/run.
  def self.run
    width = 640
    height = 640

    scene = self.scene()
    camera = PerspectiveCamera.new(width, height)

    camera.each_sample_with_ray do |p_film, ray|
      hit_info = trace(ray, scene)
      next unless hit_info

      camera[p_film] = shade(hit_info, scene.lights)
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

    sphere1 = Sphere.new(center: Point3.new(0.0, 0.0, 2.0), radius: 1.0,
                         color: Color.new(1.0, 0.0, 0.0))
    sphere2 = Sphere.new(center: Point3.new(0.0, 2.0, 3.0), radius: 1.0,
                         color: Color.new(1.0, 0.0, 1.0))
    plane = Plane.new(Point3.new(0.0, -0.6, 0.0), Normal3.new(0.1, 1.0, 0.0),
                      color: Color.new(1.0, 1.0, 0.0))

    scene.add_shape(sphere1)
    scene.add_shape(sphere2)
    scene.add_shape(plane)

    scene.add_light(PointLight.new(Point3.new(10.0, 10.0, -10.0)))
    scene.add_light(PointLight.new(Point3.new(10.0, 90.0, -10.0), color: Color.new(0.0, 1.0, 1.0)))
    scene
  end

  # Calculates shading for a hitpoint.
  def self.shade(hit_info, lights)
    acc = Color.new(0.0, 0.0, 0.0)

    lights.each do |l|
      acc.add!(diffuse(hit_info, l))
    end

    acc.add!(ambient(hit_info))
  end

  # Calculates the ambient shading.
  def self.ambient(hit_info)
    hit_info[:shape].color.mul(0.1) # ambient factor
  end

  # Calculates the diffuse shading
  def self.diffuse(hit_info, light)
    lp = light.p.sub(hit_info[:p]).normalize

    diffuse = hit_info[:n].dot(lp)
    diffuse = 0 if diffuse < 0
    diffuse *= 0.9 # diffuse factor

    hit_info[:shape].color.mul(diffuse).mul!(light.color)
  end
end
