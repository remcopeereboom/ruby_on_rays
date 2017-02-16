module RubyOnRays
  # Vector2
  #
  # A Vector2 represents a direction in 2D space.
  class Vector2
    # Returns a unit vector in the x-direction.
    # @return [Vector2]
    def self.i
      Vector2.new(1.0, 0.0)
    end

    # Returns a unit vector in the y-direction.
    # @return [Vector2]
    def self.j
      Vector2.new(0.0, 1.0)
    end

    # @!attribute x [rw] The x-coordinate.
    #   @return [Float]
    attr_accessor :x

    # @!attribute y [rw] The y-coordinate.
    #   @return [Float]
    attr_accessor :y

    # Initializes a new vector with the given components.
    # @param x [Float] The x-direction. Be careful not to pass an Integer.
    # @param y [Float] The y-direction. Be careful not to pass an Integer.
    def initialize(x, y)
      @x = x
      @y = y
    end

    # Returns a new vector pointing in the opposite direction.
    # @return [Vector2]
    def -@
      Vector2.new(-@x, -@y)
    end

    # Adds a vector. Does not mutate self.
    # @param rhs [Vector2]
    # @return [Vector2]
    def add(rhs)
      Vector2.new(@x + rhs.x, @y + rhs.y)
    end

    # Adds a vector to self.
    # @param rhs [Vector3]
    # @return [self]
    def add!(rhs)
      @x += rhs.x
      @y += rhs.y
      self
    end

    # Subtracts a vector. Does not mutate self.
    # @param rhs [Vector2]
    # @return [Vector2]
    def sub(rhs)
      Vector2.new(@x - rhs.x, @y - rhs.y)
    end

    # Subtracts a vector from self.
    # @param rhs [Vector2]
    # @return [self]
    def sub!(rhs)
      @x -= rhs.x
      @y -= rhs.y
      self
    end

    # Returns the vector-scalar product. Does not mutate self.
    # @param rhs [Float]
    # @return [Vector2]
    def mul(rhs)
      Vector2.new(@x * rhs, @y * rhs)
    end

    # Multiplies self by a scalar.
    # @param rhs [Float]
    # @return [self]
    def mul!(rhs)
      @x *= rhs
      @y *= rhs
      self
    end

    # Returns the vector-scalar quotient. Does not mutate self.
    # @param rhs [Float]
    # @return [Vector2]
    # @note Does not check for 0 divisor or 0 numerators!
    def div(rhs)
      inverse = 1.0 / rhs
      Vector2.new(@x * inverse, @y * inverse)
    end

    # Divides self by a scalar.
    # @param rhs [Float]
    # @return [self]
    # @note Does not check for 0 divisor or 0 numerators!
    def div!(rhs)
      inverse = 1.0 / rhs
      @x *= inverse
      @y *= inverse
      self
    end

    # Returns the dot product.
    # @param rhs [Vector2]
    # @return [Float]
    def dot(rhs)
      @x * rhs.x + @y * rhs.y
    end

    # Compares the vector to another vector or another object.
    # @param other [Vector2, Object]
    # @return [Boolean] False if other is not a Vector2 or if other points in
    #   a different direction.
    def ==(other)
      return false unless other.is_a? Vector2
      @x == other.x && @y == other.y
    end

    # Returns the length of the vector.
    # @return [Float]
    def length
      Math.sqrt(@x * @x + @y * @y)
    end

    # Returns the length squared of the vector. Use this if you only care
    # about the relative magnitudes of vector as this method avoids calculating
    # the expensive square root.
    # @return [Float]
    def length_squared
      @x * @x + @y * @y
    end

    # Returns a unit vector in the same direction. Does not mutate self.
    # @return [Vector2]
    def normalize
      f = 1.0 / length
      Vector2.new(@x * f, @y * f)
    end

    # Normalizes self.
    # @return [self]
    def normalize!
      f = 1.0 / length
      @x *= f
      @y *= f
      self
    end

    # Returns a string representation of the vector.
    # @return [String]
    def to_s
      "v<#{@x}, #{@y}>"
    end

    # Returns an array with the direction components.
    # @return [Array<Float>]
    def to_a
      [@x, @y]
    end

    # Returns a hash representation of the vector.
    # @return [Hash<Symbol, Float>]
    def to_h
      { x: @x, y: @y }
    end
  end
end
