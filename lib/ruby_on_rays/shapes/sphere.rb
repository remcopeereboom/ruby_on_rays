module RubyOnRays
  # Sphere
  #
  # Describes the surface of mathematical sphere (a spherical shell).
  class Sphere
    # @!attribute c [r] The center of the sphere.
    #   @return [Point3]
    attr_reader :c
    alias center c

    # @!attribute r [r] The radius of the sphere.
    #   @return [Float]
    attr_reader :r
    alias radius r

    # @!attribute color [r] The color of the sphere.
    #   @return [Color]
    attr_reader :color

    # Initializes a new sphere with the given parameters.
    # @param center [Point3] The position of the center of the sphere.
    # @param radius [Float] The radius of the sphere. Must be non-negative.
    # @param color [Color] The color of the sphere.
    def initialize(center: Point3.origin,
                   radius: 1.0,
                   color: Color.new(rand, rand, rand))
      fail ArgumentError, "Not a valid radius (#{r} for 0+)" if radius < 0

      @c = center
      @r = radius
      @color = color

      # Cache:
      @r2 = @r * @r
      @c2 = @c.dot(@c)
    end

    # rubocop:disable all

    # Returns true if there is an intersection between the ray and the sphere.
    # @param ray [Ray3]
    # @return [Boolean]
    def intersection?(ray)
      a = ray.d.dot(ray.d)
      b = 2.0 * ray.d.dot(ray.o.sub(@c))
      c = @c2 - 2.0 * @c.dot(ray.o) - @r2

      d2 = b**2 - 4 * a * c
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

      true
    end

    # Finds the intersection between the ray and the sphere.
    # @param ray [Ray3]
    # @return [nil] if no such intersection.
    # @return [HitInfo] if an intersection was found.
    def intersection(ray)
      a = ray.d.dot(ray.d)
      b = 2.0 * ray.d.dot(ray.o.sub(@c))
      c = @c2 - 2.0 * @c.dot(ray.o) - @r2

      d2 = b**2 - 4 * a * c
      return nil unless d2 > 0

      t0 = (-b - Math.sqrt(d2)) / (2 * a)
      t1 = (-b + Math.sqrt(d2)) / (2 * a)

      t0, t1 = t1, t0 if t0 > t1
      return nil if t1 < ray.tmin || t0 > ray.tmax

      t_hit = t0
      if t_hit < ray.tmin
        t_hit = t1
        return nil if t_hit > ray.tmax
      end

      p_hit = ray[t_hit]
      n_hit = (p_hit.sub(@c).div @r).to_n

      { t: t_hit, p: p_hit, n: n_hit, shape: self }
    end

    # rubocop:enable all
  end
end
