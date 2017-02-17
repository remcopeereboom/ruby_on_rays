module RubyOnRays
  # Color
  #
  # Color represents a 3-sampling of a color. The coefficients {r}, {g}, and {b}
  # are assumed to represent samplings of a pure, a pure green and a pure blue
  # color, but in principle they can be samplings of any spectrum. For more
  # realistic renderings, clients should consider writing custom color classes
  # that handle inter conversions between spectra as generally the default
  # operators will give mathematically inaccurate results. For non-phyiscally
  # correct renderings, the default renderings may still like photo-realistic,
  # they will merely not be phyiscally exact.
  class Color
    # Returns a new color with given color components.
    # @param red [Float]
    # @param green [Float]
    # @param blue [Float]
    # @return [Color]
    def self.rgb(red, green, blue)
      Color.new(red, green, blue)
    end

    # @!attribute r [rw] The red color component.
    #   @return [Float]
    attr_accessor :r
    alias red r

    # @!attribute g [rw] The green color component.
    #   @return [Float]
    attr_accessor :g
    alias green g

    # @!attribute b [rw] The blue color component.
    #   @return [Float]
    attr_accessor :b
    alias blue b

    # Initializes a new color with the given color components.
    # @param red [Float]
    # @param green [Float]
    # @param blue [Float]
    def initialize(red, green, blue)
      @r = red
      @g = green
      @b = blue
    end

    # Returns the negation of the color.
    # @return [Color] A new color.
    def -@
      Color.new(-@r, -@g, -@b)
    end

    # Sums the color components, returns a new color.
    # @param rhs [Color]
    # @return [Color]
    def add(rhs)
      Color.new(@r + rhs.r, @g + rhs.g, @b + rhs.b)
    end

    # Adds the other color to self.
    # @param rhs [Color]
    # @return [self]
    def add!(rhs)
      @r += rhs.r
      @g += rhs.g
      @b += rhs.b
      self
    end

    # Subtracts the color components, returns a new color.
    # @param rhs [Color]
    # @return [Color]
    def sub(rhs)
      Color.new(@r - rhs.r, @g - rhs.g, @b - rhs.b)
    end

    # Subtracts the other color from self.
    # @param rhs [Color]
    # @return [Color]
    def sub!(rhs)
      @r -= rhs.r
      @g -= rhs.g
      @b -= rhs.b
      self
    end

    # @overload mul(numeric)
    #   Multiplies the color components by a scalar, returns a new color.
    #   @param rhs [Numeric]
    #   @return [Color]
    # @overload mul(color)
    #   Multiplies the color components, returns a new color.
    #   @param rhs [Color]
    #   @return [Color]
    def mul(rhs)
      case rhs
      when Numeric
        mul_numeric(rhs)
      when Color
        mul_color(rhs)
      else
        fail ArgumentError, "Can't multiply a color by a #{rhs.class}."
      end
    end

    # @overload mul!(numeric)
    #   Multiplies self by the scalar.
    #   @param rhs [Numeric]
    #   @return [self]
    # @overload mul!(color)
    #   Multiplies self by the color.
    #   @param rhs [Color]
    #   @return [self]
    def mul!(rhs)
      case rhs
      when Numeric
        mul_numeric!(rhs)
      when Color
        mul_color!(rhs)
      else
        fail ArgumentError, "Can't multiply a color by a #{rhs.class}."
      end
    end

    # @overload div(color)
    #   Divides the color components by a scalar, returns a new color.
    #   @param rhs [Numeric]
    #   @return [Color]
    # @overload div(color)
    #   Divides the color components, returns a new color.
    #   @param rhs [Color]
    #   @return [Color]
    def div(rhs)
      case rhs
      when Numeric
        div_numeric(rhs)
      when Color
        div_color(rhs)
      else
        fail ArgumentError, "Can't divide a color by a #{rhs.class}."
      end
    end

    # @overload div!(numeric)
    #   Divides self by the scalar.
    #   @param rhs [Numeric]
    #   @return [self]
    # @overload div!(color)
    #   Divides self by the color.
    #   @param rhs [Color]
    #   @return [self]
    def div!(rhs)
      case rhs
      when Numeric
        div_numeric!(rhs)
      when Color
        div_color!(rhs)
      else
        fail ArgumentError, "Can't divide a color by a #{rhs.class}."
      end
    end

    # Are two colors equal?
    # @param other [Color, Object]
    # @return [Boolean] False if rhs is not a Color, or if is a different color.
    def ==(other)
      return false unless other.is_a? Color
      @r == other.r && @g == other.g && @b == other.b
    end

    # Multiplies the color components by the scalar, returns a new color.
    # @param rhs [Numeric]
    # @return [Color]
    def mul_numeric(rhs)
      Color.new(@r * rhs, @g * rhs, @b * rhs)
    end

    # Multiplies self by a scalar.
    # @param rhs [Numeric]
    # @return [self]
    def mul_numeric!(rhs)
      @r *= rhs
      @g *= rhs
      @b *= rhs
      self
    end

    # Multiplies the color components, returns a new color.
    # @param rhs [Color]
    # @return [Color]
    def mul_color(rhs)
      Color.new(@r * rhs.r, @g * rhs.g, @b * rhs.b)
    end

    # Multiplies self by a color.
    # @param rhs [Color]
    # @return [self]
    def mul_color!(rhs)
      @r *= rhs.r
      @g *= rhs.g
      @b *= rhs.b
      self
    end

    # Divides the color components by the scalar, returns a new color.
    # @param rhs [Numeric]
    # @return [Color]
    def div_numeric(rhs)
      Color.new(@r / rhs, @g / rhs, @b / rhs)
    end

    # Divides self by a scalar.
    # @param rhs [Numeric]
    # @return [self]
    def div_numeric!(rhs)
      @r /= rhs
      @g /= rhs
      @b /= rhs
      self
    end

    # Divides the color components, returns a new color.
    # @param rhs [Color]
    # @return [Color]
    def div_color(rhs)
      Color.new(@r / rhs.r, @g / rhs.g, @b / rhs.b)
    end

    # Divides self by a color.
    # @param rhs [Color]
    # @return [self]
    def div_color!(rhs)
      @r /= rhs.r
      @g /= rhs.g
      @b /= rhs.b
      self
    end

    # Is the color black, i.e. are all it's components 0?
    # @return [Boolean]
    def black?
      @r == 0.0 && @g == 0.0 && @b == 0.0
    end

    # Returns a string representation of the color.
    # @return [String]
    def to_s
      "rgb(#{@r}, #{@g}, #{@b})"
    end

    # Returns an array representation of the color.
    # @return [Array<Float>]
    def to_a
      [@r, @h, @b]
    end

    # Returns a hash representation of the color.
    # @return [Hash<Symbol, Float>]
    def to_h
      { r: @r, g: @g, b: @b }
    end
  end
end
