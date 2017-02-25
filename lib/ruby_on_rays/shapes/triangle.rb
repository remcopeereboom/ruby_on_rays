module RubyOnRays
  # Triangle
  #
  # Describes the surface of a triangle.
  class Triangle
    # @!attribute color [r] The color of the triangle.
    #   @return [Color]
    attr_reader :color

    # Initializes a new triangle shape.
    # @param a [Point3] A vertex of the triangle.
    # @param b [Point3] A vertex of the triangle.
    # @param c [Point3] A vertex of the triangle.
    # @note The surface normal is assumed to put in the positive direction
    #   if the vertices are supplied in clockwise order. More formally, the
    #   surface normal n is defined such that n = (b - a).cross(c - a).
    def initialize(a, b, c, color: Color.new(rand, rand, rand))
      @a = a
      @b = b
      @c = c
      @color = color

      # Cache:
      @n = b.sub(a).cross(c.sub(a))
      @e0 = b.sub(a)
      @e1 = c.sub(a)
    end

    # rubocop:disable all

    # Returns true if there is an intersection between the ray and the triangle.
    # @param ray [Ray3]
    # @return [Boolean]
    def intersection?(ray)
      # Use MT triangle intersection algorithm:

      # Compute s0
      s0 = ray.d.cross(@e1)
      divisor = s0.dot(@e0)
      return false if divisor == 0.0 # Not on plane.
      inverse_divisor = 1.0 / divisor

      # Compute b0 (first barycentric coordinate)
      d = ray.o.sub(@a)
      b0 = d.dot(s0) * inverse_divisor
      return false if b0 < 0.0 || b0 > 1.0 # Out of triangle.

      # Compute b1 (second barycentric coordinate)
      s1 = d.cross(@e0)
      b1 = ray.d.dot(s1) * inverse_divisor
      return false if b1 < 0.0 || b0 + b1 > 1.0 # Out of triangle.

      true
    end

    # Finds the intersection between the ray and the triangle.
    # @param ray [Ray3]
    # @return [nil] if no such intersection.
    # @return [HitInfo] if an intersection was found.
    def intersection(ray)
      # Use MT triangle intersection algorithm:

      # Compute s0
      s0 = ray.d.cross(@e1)
      divisor = s0.dot(@e0)
      return nil if divisor == 0.0 # Not on plane.
      inverse_divisor = 1.0 / divisor

      # Compute b0 (first barycentric coordinate)
      d = ray.o.sub(@a)
      b0 = d.dot(s0) * inverse_divisor
      return nil if b0 < 0.0 || b0 > 1.0 # Out of triangle.

      # Compute b1 (second barycentric coordinate)
      s1 = d.cross(@e0)
      b1 = ray.d.dot(s1) * inverse_divisor
      return nil if b1 < 0.0 || b0 + b1 > 1.0 # Out of triangle.

      t_hit = @e1.dot(s1) * inverse_divisor
      return nil if t_hit < ray.tmin || t_hit > ray.tmax

      { t: t_hit, n: @n, p: ray[t_hit], shape: self }
    end

    # rubocop:enable all
  end
end
