module RubyOnRays
  # Vector3
  #
  # A Vector3 represents a direction in 3D space.
  class Vector3
    # Returns a unit vector in the x-direction.
    # @return [Vector3]
    def self.i
      Vector3.new(1.0, 0.0, 0.0)
    end

    # Returns a unit vector in the y-direction.
    # @return [Vector3]
    def self.j
      Vector3.new(0.0, 1.0, 0.0)
    end

    # Returns a unit vector in the z-direction.
    # @return [Vector3]
    def self.k
      Vector3.new(0.0, 0.0, 1.0)
    end

    # @!attribute x [rw] The component in the x-direction.
    #   @return [Float]
    attr_accessor :x

    # @!attribute y [rw] The component in the y-direction.
    #   @return [Float]
    attr_accessor :y

    # @!attribute z [rw] The component in the z-direction.
    #   @return [Float]
    attr_accessor :z

    # Initializes a new vector with the given components.
    # @param x [Float] The x-direction. Be careful not to pass an Integer.
    # @param y [Float] The y-direction. Be careful not to pass an Integer.
    # @param z [Float] The z-direction. Be careful not to pass an Integer.
    def initialize(x, y, z)
      @x = x
      @y = y
      @z = z
    end

    # Returns a new vector pointing in the opposite direction.
    # @return [Vector3]
    def -@
      Vector3.new(-@x, -@y, -@z)
    end

    # Adds a vector. Does not mutate self.
    # @param rhs [Vector3]
    # @return [Vector3]
    def add(rhs)
      Vector3.new(@x + rhs.x, @y + rhs.y, @z + rhs.z)
    end

    # Adds a vector to self.
    # @param rhs [Vector3]
    # @return [self]
    def add!(rhs)
      @x += rhs.x
      @y += rhs.y
      @z += rhs.z
      self
    end

    # Subtracts a vector. Does not mutate self.
    # @param rhs [Vector3]
    # @return [Vector3]
    def sub(rhs)
      Vector3.new(@x - rhs.x, @y - rhs.y, @z - rhs.z)
    end

    # Subtracts a vector from self.
    # @param rhs [Vector3]
    # @return [self]
    def sub!(rhs)
      @x -= rhs.x
      @y -= rhs.y
      @z -= rhs.z
      self
    end

    # Returns the vector-scalar product. Does not mutate self.
    # @param rhs [Float]
    # @return [Vector3]
    def mul(rhs)
      Vector3.new(@x * rhs, @y * rhs, @z * rhs)
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

    # Returns the vector-scalar quotient. Does not mutate self.
    # @param rhs [Float]
    # @return [Vector3]
    # @note Does not check for 0 divisor or 0 numerators!
    def div(rhs)
      inverse = 1.0 / rhs
      Vector3.new(@x * inverse, @y * inverse, @z * inverse)
    end

    # Divides self by a scalar.
    # @param rhs [Float]
    # @return [self]
    # @note Does not check for 0 divisor or 0 numerators!
    def div!(rhs)
      inverse = 1.0 / rhs
      @x *= inverse
      @y *= inverse
      @z *= inverse
      self
    end

    # Returns the dot product.
    # @param rhs [Vector3]
    # @return [Float]
    def dot(rhs)
      @x * rhs.x + @y * rhs.y + @z * rhs.z
    end

    # Returns the vector-vector cross product.
    # @param rhs [Vector3]
    # @return [Float]
    def cross(rhs)
      x = @y * rhs.z - @z * rhs.y
      y = @z * rhs.x - @x * rhs.z
      z = @x * rhs.y - @y * rhs.x

      Vector3.new(x, y, z)
    end

    # Compares the vector to another vector or another object.
    # @param other [Vector3, Object]
    # @return [Boolean] False if other is not a Vector3 or if other points in
    #   a different direction.
    def ==(other)
      return false unless other.is_a? Vector3
      @x == other.x && @y == other.y && @z == other.z
    end

    # Returns the length of the vector.
    # @return [Float]
    def length
      Math.sqrt(@x * @x + @y * @y + @z * @z)
    end

    # Returns the length squared of the vector. Use this if you only care
    # about the relative magnitudes of vectors as this method avoids calculating
    # the expensive square root.
    # @return [Float]
    def length_squared
      @x * @x + @y * @y + @z * @z
    end

    # Returns a unit vector in the same direction. Does not mutate self.
    # @return [Vector3]
    def normalize
      f = 1.0 / length
      Vector3.new(@x * f, @y * f, @z * f)
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

    # Returns a copy.
    # @return [Vector3]
    def to_v
      Vector3.new(@x, @y, @z)
    end

    # Returns a string representation of the vector.
    # @return [String]
    def to_s
      "v<#{@x}, #{@y}, #{@z}>"
    end

    # Returns an array with the direction components.
    # @return [Array<Float>]
    def to_a
      [@x, @y, @z]
    end

    # Returns a hash representation of the vector.
    # @return [Hash<Symbol, Float>]
    def to_h
      { x: @x, y: @y, z: @z }
    end
  end
end
