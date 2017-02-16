module RubyOnRays
  # Point3
  #
  # A Point3 represents a zero-dimensional location in 3D space.
  class Point3
    # Returns a new Point3 on the origin.
    # @return [Point3]
    def self.origin
      Point3.new(0.0, 0.0, 0.0)
    end

    # @!attribute x [rw] The x-coordinate.
    #   @return [Float]
    attr_accessor :x

    # @!attribute y [rw] The y-coordinate.
    #   @return [Float]
    attr_accessor :y

    # @!attribute z [rw] The z-coordinate.
    #   @return [Float]
    attr_accessor :z

    # Initializes a new point with the given parameters.
    # @param x [Float] The x-coordinate. Be careful not to pass an Integer.
    # @param y [Float] The y-coordinate. Be careful not to pass an Integer.
    # @param z [Float] The z-coordinate. Be careful not to pass an Integer.
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    # Translates a point by a vector, does not mutate self.
    # @param rhs [Vector3]
    # @return [Point3]
    def add(rhs)
      Point3.new(@x + rhs.x, @y + rhs.y, @z + rhs.z)
    end

    # Translates this point by a vector.
    # @param rhs [Vector3]
    # @return [self]
    def add!(rhs)
      @x += rhs.x
      @y += rhs.y
      @z += rhs.z
      self
    end

    # @overload sub(vector)
    #   Translates a point by a vector, does not mutate self.
    #   @param vector [Vector3]
    #   @return [Point3]
    # @overload sub(point)
    #   Returns the vector from other to self.
    #   @param point [Point3]
    #   @return [Vector3]
    def sub(rhs)
      case rhs
      when Point3
        Vector3.new(@x - rhs.x, @y - rhs.y, @z - rhs.z)
      when Vector3
        Point3.new(@x - rhs.x, @y - rhs.y, @z - rhs.z)
      else fail ArgumentError "Can't subtract a #{rhs.class} from a Point3."
      end
    end

    # Translates the point by the vector. Mutates self.
    # @param rhs [Vector3]
    # @return [self]
    def sub!(rhs)
      @x -= rhs.x
      @y -= rhs.y
      @z -= rhs.z
      self
    end

    # Returns the dot product with another point or with a vector.
    # @param rhs [Point3, Vector3, Normal3]
    # @return [Float]
    def dot(rhs)
      @x * rhs.x + @y * rhs.y + @z * rhs.z
    end

    # Compares the point to another point or another object.
    # @param other [Vector3, Object]
    # @return [Boolean] False if other is not a Point3 or if other points in
    #   a different direction.
    def ==(other)
      return false unless other.is_a? Point3
      @x == other.x && @y == other.y && @z == other.z
    end

    # Returns the distance between this point and another point.
    # @param other [Point3]
    # @return [Float] The distance squared.
    def distance_to(other)
      dx = @x - other.x
      dy = @y - other.y
      dz = @z - other.z

      Math.sqrt(dx * dx + dy * dy + dz * dz)
    end

    # Returns the square of the distance between this point and another point.
    # @param other [Point2]
    # @return [Float] The distance squared.
    def distance_squared_to(other)
      dx = @x - other.x
      dy = @y - other.y
      dz = @z - other.z

      dx * dx + dy * dy + dz * dz
    end

    # Returns a copy.
    # @return [Point3]
    def to_p
      Point3.new(@x, @y, @z)
    end

    # Returns a vector with the same components.
    # @return [Vector3]
    def to_v
      Vector3.new(@x, @y, @z)
    end

    # Returns a normal with the same components.
    # @return [Normal3]
    def to_n
      Normal3.new(@x, @y, @z)
    end

    # Returns a string representation of the point.
    # @return [String]
    def to_s
      "p(#{@x}, #{@y}, #{@z})"
    end

    # Returns an array with the coordinates.
    # @return [Array<Float>]
    def to_a
      [@x, @y, @z]
    end

    # Returns a hash representation of the point.
    # @return [Hash<Symbol, Float>]
    def to_h
      { x: @x, y: @y, z: @z }
    end
  end
end
