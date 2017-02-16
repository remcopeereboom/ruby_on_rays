module RubyOnRays
  # Point2
  #
  # A Point2 represents a zero-dimensional location in 2D space.
  class Point2
    # Returns a new Point2 on the origin.
    # @return [Point2]
    def self.origin
      Point2.new(0.0, 0.0)
    end

    # @!attribute x [rw] The x-coordinate.
    #   @return [Float]
    attr_accessor :x

    # @!attribute y [rw] The y-coordinate.
    #   @return [Float]
    attr_accessor :y

    # Initializes a new point with the given parameters.
    # @param x [Float] The x-coordinate. Be careful not to pass an Integer.
    # @param y [Float] The y-coordinate. Be careful not to pass an Integer.
    def initialize(x, y)
      @x = x
      @y = y
    end

    # Translates a point by a vector, does not mutate self.
    # @param v [Vector2]
    # @return [Point2]
    def add(v)
      Point2.new(@x + v.x, @y + v.y)
    end

    # Translates this point by a vector.
    # @param v [Vector2]
    # @return [self]
    def add!(v)
      @x += v.x
      @y += v.y
      self
    end

    # @overload sub(vector)
    #   Translates a point by a vector, does not mutate self.
    #   @param vector [Vector2]
    #   @return [Point2]
    # @overload sub(point)
    #   Returns the vector from other to self.
    #   @param other [Point2]
    #   @return [Vector2]
    def sub(rhs)
      case rhs
      when Vector2
        Point2.new(@x - rhs.x, @y - rhs.y)
      when Point2
        Vector2.new(@x - rhs.x, @y - rhs.y)
      else fail ArgumentError, "Can't subtract a #{rhs.class} from a Point2"
      end
    end

    # Translates the point by the vector. Mutates self.
    # @param rhs [Vector2]
    # @return [self]
    def sub!(rhs)
      @x -= rhs.x
      @y -= rhs.y
      self
    end

    # Returns the dot product.
    # @param rhs [Point2, Vector2]
    # @return [Float]
    def dot(rhs)
      @x * rhs.x + @y * rhs.y
    end

    # Compares the point to another point or another object.
    # @param other [Point2, Object]
    # @return [Boolean] False if other is not a Point2 or if other points to
    #   a different location.
    def ==(other)
      return false unless other.is_a? Point2
      @x == other.x && @y == other.y
    end

    # Returns the distance between this point and another point.
    # @param other [Point2]
    # @return [Float] The distance.
    def distance_to(other)
      dx = @x - other.x
      dy = @y - other.y

      Math.sqrt(dx * dx + dy * dy)
    end

    # Returns the square of the distance between this point and another point.
    # @param other [Point2]
    # @return [Float] The distance squared.
    def distance_squared_to(other)
      dx = @x - other.x
      dy = @y - other.y

      dx * dx + dy * dy
    end

    # Returns a copy of the point.
    # @return [Point2]
    def to_p
      Point2.new(@x, @y)
    end

    # Returns a vector with the same components.
    # @return [Vector2]
    def to_v
      Vector2.new(@x, @y)
    end

    # Returns a string representation of the point.
    # @return [String]
    def to_s
      "p(#{@x}, #{@y})"
    end

    # Returns an array with the coordinates.
    # @return [Array<Float>]
    def to_a
      [@x, @y]
    end

    # Returns a hash representation of the point.
    # @return [Hash<Symbol, Float>]
    def to_h
      { x: @x, y: @y }
    end
  end
end
