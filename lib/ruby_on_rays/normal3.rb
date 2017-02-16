module RubyOnRays
  # Normal3
  #
  # Normal3 represents a surface normal, a vector perpendicular to the surface
  # at a given point. Normals are distinct from vectors in that they behave
  # differently under certain transformations (since they need to remain
  # perpendicular to the surface).
  #
  # @note Despite the terminology, Normal3's are not guaranteed to be
  # normalized.
  class Normal3
    # @!attribute x [rw] The component in the x-direction.
    #   @return [Float]
    attr_accessor :x

    # @!attribute y [rw] The component in the y-direction.
    #   @return [Float]
    attr_accessor :y

    # @!attribute z [rw] The component in the z-direction.
    #   @return [Float]
    attr_accessor :z

    # Initializes a new normal with the given components.
    # @param x [Float] The x-direction. Be careful not to pass an Integer.
    # @param y [Float] The y-direction. Be careful not to pass an Integer.
    # @param z [Float] The z-direction. Be careful not to pass an Integer.
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    # Adds a normal. Does not mutate self.
    # @param rhs [Normal3]
    # @return [Normal3]
    def add(rhs)
      Normal3.new(@x + rhs.x, @y + rhs.y, @z + rhs.z)
    end

    # Adds a normal to self.
    # @param rhs [Normal3]
    # @return [self]
    def add!(rhs)
      @x += rhs.x
      @y += rhs.y
      @z += rhs.z
      self
    end

    # Subtracts a normal. Does not mutate self.
    # @param rhs [Normal3]
    # @return [Vector3]
    def sub(rhs)
      Normal3.new(@x - rhs.x, @y - rhs.y, @z - rhs.z)
    end

    # Subtracts a normal from self.
    # @param rhs [Normal]
    # @return [self]
    def sub!(rhs)
      @x -= rhs.x
      @y -= rhs.y
      @z -= rhs.z
      self
    end

    # Returns the normal-scalar product. Does not mutate self.
    # @param rhs [Float]
    # @return [Normal3]
    def mul(rhs)
      Normal3.new(@x * rhs, @y * rhs, @z * rhs)
    end

    # Multiplies self by a scalar.
    # @param rhs [Float]
    # @return [self]
    def mul!(rhs)
      @x *= rhs
      @y *= rhs
      @z *= rhs
      self
    end

    # Returns the normal-scalar quotient. Does not mutate self.
    # @param rhs [Float]
    # @return [Normal3]
    # @note Does not check for 0 divisor or 0 numerators!
    def div(rhs)
      f = 1.0 / rhs
      Normal3.new(@x * f, @y * f, @z * f)
    end

    # Divides self by a scalar.
    # @param rhs [Float]
    # @return [self]
    # @note Does not check for 0 divisor or 0 numerators!
    def div!(rhs)
      f = 1.0 / rhs
      @x *= f
      @y *= f
      @z *= f
      self
    end

    # Returns the dot product.
    # @param rhs [Point3, Vector3, Normal3]
    # @return [Float]
    def dot(rhs)
      @x * rhs.x + @y * rhs.y + @z * rhs.z
    end

    # Compares the normal to another normal or another object.
    # @param other [Normal3, Object]
    # @return [Boolean] False if other is not a Normal3 or if other points in
    #   a different direction.
    def ==(other)
      return false unless other.is_a? Normal3
      @x == other.x && @y == other.y && @z == other.z
    end

    # Returns the length of the normal.
    # @return [Float]
    def length
      Math.sqrt(@x * @x + @y * @y + @z * @z)
    end

    # Returns the length squared of the normal. Use this if you only care
    # about the relative magnitudes of normals as this method avoids calculating
    # the expensive square root.
    # @return [Float]
    def length_squared
      @x * @x + @y * @y + @z * @z
    end

    # Returns a unit normal in the same direction. Does not mutate self.
    # @return [Normal3]
    def normalize
      f = 1.0 / length
      Normal3.new(@x * f, @y * f, @z * f)
    end

    # Normalizes self.
    # @return [self]
    def normalize!
      f = 1.0 / length
      @x *= f
      @y *= f
      @z *= f
      self
    end

    # Returns a point with the same components.
    # @return [Point3]
    def to_p
      Point3.new(@x, @y, @z)
    end

    # Returns a vector pointing in the same direction.
    # @return [Vector3]
    def to_v
      Vector3.new(@x, @y, @z)
    end

    # Returns a copy of the normal.
    # @return [Normal3]
    def to_n
      Normal3.new(@x, @y, @z)
    end

    # Returns a string representation of the normal.
    # @return [String]
    def to_s
      "n<#{@x}, #{@y}, #{@z}>"
    end

    # Returns an array with the direction components.
    # @return [Array<Float>]
    def to_a
      [@x, @y, @z]
    end

    # Returns a hash representation of the normal.
    # @return [Hash<Symbol, Float>]
    def to_h
      { x: @x, y: @y, z: @z }
    end
  end
end
