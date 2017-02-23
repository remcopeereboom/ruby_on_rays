module RubyOnRays
  # Plane
  #
  # Describes the surface of a mathematical plane.
  class Plane
    # Returns a plane containing both the x-axis and the y-axis.
    # @return [Plane]
    def self.xy(color: Color.new(rand, rand, rand))
      Plane.new(Point3.origin, Normal3.new(0.0, 0.0, 1.0), color: color)
    end

    # Returns a plane containing both the x-axis and the z-axis.
    # @return [Plane]
    def self.xz(color: Color.new(rand, rand, rand))
      Plane.new(Point3.origin, Normal3.new(0.0, 1.0, 0.0), color: color)
    end

    # Returns a plane containing both the y-axis and the z-axis.
    # @return [Plane]
    def self.yz(color: Color.new(rand, rand, rand))
      Plane.new(Point3.origin, Normal3.new(1.0, 0.0, 0.0), color: color)
    end

    # @!attribute n [r] The surface normal (is normalized).
    #   @return [Normal3]
    attr_reader :n
    alias normal n

    # @!attribute color [r] The color of the plane.
    #   @return [Color]
    attr_reader :color

    # Initializes a new plane.
    # @param point [Point3] A point on the surface.
    # @param normal [Normal3] A normal to the surface. Doesn't need to be
    #   normalized.
    def initialize(point, normal, color: Color.new(rand, rand, rand))
      @p = point
      @n = normal.normalize
      @color = color
    end

    # Returns true if there is an intersection between the ray and the plane.
    # @param ray [Ray3]
    # @return [Boolean]
    def intersection?(ray)
      b = ray.d.dot(n)
      return false if b == 0.0

      a = @p.sub(ray.o).dot(n)
      t = a / b

      t < ray.tmin || t > ray.tmax
    end

    # Finds the intersection between the ray and the plane.
    # @param ray [Ray3]
    # @return [nil] if no such intersection.
    # @return [HitInfo] if an intersection was found.
    def intersection(ray)
      b = ray.d.dot(@n)
      return nil if b == 0.0

      a = @p.sub(ray.o).dot(@n)
      t = a / b

      return nil if t < ray.tmin || t > ray.tmax
      ray[t]

      { t: t, p: ray[t], n: @n, shape: self }
    end
  end
end
