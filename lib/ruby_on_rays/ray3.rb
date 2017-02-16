module RubyOnRays
  # Ray3
  #
  # A Ray specifies a semi-infinite line by it's origin and a direction.
  # The ray can be described by the parametric equation "O + Dt", where
  # O is the point of origin, D the direction of the ray, and t the parametric
  # parameter. The parametric parameter is bounded to the range tmin...tmax.
  class Ray3
    # @!attribute origin [r] The spawn point of the ray.
    #   @return [Point3]
    attr_reader :o

    # @!attribute direction [r] The direction of the ray.
    #   @return [Vector3]
    attr_reader :d

    # @!attribute tmin [r] The smallest legal value of the parametric
    #   parameter t.
    #   @return [Float]
    attr_reader :tmin

    # @!attribute tmax [r] The largest legal value of the parametric
    #   parameter t.
    #   @return [Float]
    attr_accessor :tmax

    # @!attribute depth [r] The recursive depth of this ray.
    #   @return [Integer]
    attr_reader :depth

    # Initializes a new Ray.
    # @param origin [Point3] The spawn point of the ray.
    # @param direction [Vector3] The direction of the ray.
    # @param tmin [Float] Defines the smallest legal value of the parametric
    #   paramter t.
    # @param tmax [Float] Defines the largest legal value of the parametric
    #   paramter t.
    def initialize(origin, direction,
                   tmin: 0.0, tmax: Float::INFINITY, depth: 0)
      @o = origin.freeze
      @d = direction.freeze

      @tmin = tmin
      @tmax = tmax

      @depth = depth
    end

    # Returns a point along the ray.
    # @param t [Float] The parametric parameter, must lie in the range
    #   tmin...tmax
    # @return [Point3]
    # @note Does not actually check that t lies within the valid range.
    def [](t)
      @o.add(@d.mul(t))
    end

    # Returns a string representation of the ray.
    # @return [String]
    def to_s
      "ray(#{@o} + #{@d}*t;t:#{@tmin...@tmax})"
    end
  end
end
