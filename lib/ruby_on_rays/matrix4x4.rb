module RubyOnRays
  # Matrix4x4
  #
  # Represents a 4 by 4 matrix.
  class Matrix4x4
    # @overload initialize()
    #   Initializes a new empty 4 by 4 matrix.
    # @overload initialize(elements)
    #   @param elements [Array<Float>] A 16 element array.
    def initialize(elements = nil)
      if elements
        if elements.size != 16
          fail ArgumentError,
               "Wrong number of elements (#{elements.size} for 16)"
        else
          @m = elements.dup
        end
      else
        @m = Array.new(16, 0.0)
      end
    end

    # Read element
    # @param row [Integer] Row index. Must lie within 0..3
    # @param col [Integer] Column index. Must lie within 0..3
    # @return [Float] the value at the given indices.
    def [](row, col)
      @m[4 * row + col]
    end

    # Write element
    # @param row [Integer] Row index. Must lie within 0..3
    # @param col [Integer] Column index. Must lie within 0..3
    # @param value [Float] The value to write.
    # @return [void]
    def []=(row, col, value)
      @m[4 * row + col] = value
    end

    # Are two matrices equal?
    # @param other [Matrix4x4, Object]
    # @return [false] if other is not a matrix or the elements don't match.
    # @return [true] if other is a matrix with the same elements.
    def ==(other)
      return false unless other.is_a? Matrix4x4
      @m == other.m
    end

    # Multiplies the two matrices.
    # @param other [Matrix4x4]
    # @return [Matrix4x4] The new product matrix.
    def mul(other)
      case other
      when Float
        mul_matrix_scalar(other)
      when Matrix4x4
        mul_matrix_matrix(other)
      else fail ArgumentError, "Can't multiply a matrix with a #{other.class}."
      end
    end

    # Returns the transpose of the matrix.
    # @return [Matrix4x4]
    def transpose
      Matrix4x4.new([@m[0], @m[4], @m[8],  @m[12],
                     @m[1], @m[5], @m[9],  @m[13],
                     @m[2], @m[6], @m[10], @m[14],
                     @m[3], @m[7], @m[11], @m[15]])
    end

    # rubocop:disable all

    # Returns the determinant of the matrix.
    # @return [Float]
    def determinant
       @m[0] * @m[5] * @m[10] * @m[15] +
       @m[0] * @m[6] * @m[11] * @m[13] +
       @m[0] * @m[7] * @m[9]  * @m[14] +
       @m[1] * @m[4] * @m[11] * @m[14] +
       @m[1] * @m[6] * @m[8]  * @m[15] +
       @m[1] * @m[7] * @m[10] * @m[12] +
       @m[2] * @m[4] * @m[9]  * @m[14] +
       @m[2] * @m[5] * @m[11] * @m[12] +
       @m[2] * @m[7] * @m[8]  * @m[13] +
       @m[3] * @m[4] * @m[10] * @m[13] +
       @m[3] * @m[5] * @m[8]  * @m[14] +
       @m[3] * @m[6] * @m[9]  * @m[12] -
       @m[0] * @m[5] * @m[11] * @m[14] -
       @m[0] * @m[6] * @m[9]  * @m[15] -
       @m[0] * @m[7] * @m[10] * @m[13] -
       @m[1] * @m[4] * @m[10] * @m[15] -
       @m[1] * @m[6] * @m[11] * @m[12] -
       @m[1] * @m[7] * @m[8]  * @m[14] -
       @m[2] * @m[4] * @m[11] * @m[13] -
       @m[2] * @m[5] * @m[8]  * @m[15] -
       @m[2] * @m[7] * @m[9]  * @m[12] -
       @m[3] * @m[4] * @m[9]  * @m[14] -
       @m[3] * @m[5] * @m[10] * @m[12] -
       @m[3] * @m[6] * @m[8]  * @m[13]
    end

    # rubocop:enable all

    # Returns the inverse of the matrix.
    # @return [Matrix4x4]
    def inverse
      det = determinant

      fail "Matrix is singular: #{@m}" if det.abs < 0.0001
      b = Matrix4x4.new([b00, b01, b02, b03,
                         b10, b11, b12, b13,
                         b20, b21, b22, b23,
                         b30, b31, b32, b33])

      b.mul(1.0 / det)
    end

    # Returns a String representation of the matrix.
    # @return [String]
    def to_s
      to_a.to_s
    end

    # Returns an Array representation of the matrix.
    # @return [Array<Array<Float>>]
    def to_a
      [@m[0..3], @m[4..7], @m[8..11], @m[12..15]]
    end

    # Yields the values of the elements along with the row and the column.
    # @yieldparam value [Float]
    # @yieldparam row [Integer] (0..3)
    # @yieldparam col [Integer] (0..3)
    # @return [Enumerator<each_with_indices>] if no block is given.
    # @return [self] if a block is given.
    def each_with_indices
      return enum_for(:each_with_indices) { 16 } unless block_given?

      (0...4).each do |row|
        (0...4).each do |col|
          yield @m[col + 4 * row], row, col
        end
      end

      self
    end

    protected

    # Returns the elements as an array in row first order.
    # @api private
    attr_reader :m

    private

    # Matrices are complicated and cause to many cops to fail in an unsensible
    # manner...
    # rubocop:disable all

    # Returns the product of a matrix with a scalar.
    # @param other [Float]
    # @return [Matrix4x4]
    def mul_matrix_scalar(other)
      rm = Matrix4x4.new(@m)

      (0...4).each do |row|
        (0...4).each do |col|
          rm[row, col] *= other
        end
      end

      rm
    end

    # Returns the product of two matrices.
    # @param other [Matrix4x4]
    # @return [Matrix4x4]
    def mul_matrix_matrix(other)
      rm = Matrix4x4.new
      m2 = other.m

      (0...4).each do |row|
        (0...4).each do |col|
          rm[row, col] = @m[4 * row + 0] * m2[0, col] +
                         @m[4 * row + 1] * m2[1, col] +
                         @m[4 * row + 2] * m2[2, col] +
                         @m[4 * row + 3] * m2[3, col]
        end
      end

      rm
    end

    def b00
      @m[5] * @m[10] * @m[15] +
      @m[6] * @m[11] * @m[13] +
      @m[7] * @m[ 9] * @m[14] -

      @m[5] * @m[11] * @m[14] -
      @m[6] * @m[ 9] * @m[15] -
      @m[7] * @m[10] * @m[12]
    end

    def b01
      @m[1] * @m[11] * @m[14] +
      @m[2] * @m[ 9] * @m[15] +
      @m[3] * @m[10] * @m[13] -

      @m[1] * @m[10] * @m[15] -
      @m[2] * @m[11] * @m[13] -
      @m[3] * @m[ 9] * @m[14]
    end

    def b02
      @m[1] * @m[6] * @m[15] +
      @m[2] * @m[7] * @m[13] +
      @m[3] * @m[5] * @m[14] -

      @m[1] * @m[7] * @m[14] -
      @m[2] * @m[5] * @m[15] -
      @m[3] * @m[6] * @m[13]
    end

    def b03
      @m[1] * @m[7] * @m[10] +
      @m[2] * @m[5] * @m[11] +
      @m[3] * @m[6] * @m[ 9] -

      @m[1] * @m[6] * @m[11] -
      @m[2] * @m[7] * @m[ 9] -
      @m[3] * @m[5] * @m[10]
    end

    def b10
      @m[4] * @m[11] * @m[14] +
      @m[6] * @m[ 8] * @m[15] +
      @m[7] * @m[10] * @m[12] -

      @m[4] * @m[10] * @m[15] -
      @m[6] * @m[11] * @m[12] -
      @m[7] * @m[ 8] * @m[14]
    end

    def b11
      @m[0] * @m[10] * @m[15] +
      @m[2] * @m[11] * @m[12] +
      @m[3] * @m[ 8] * @m[14] -

      @m[0] * @m[11] * @m[12] -
      @m[2] * @m[ 8] * @m[15] -
      @m[3] * @m[10] * @m[14]
    end

    def b12
      @m[0] * @m[7] * @m[14] +
      @m[2] * @m[4] * @m[15] +
      @m[3] * @m[6] * @m[12] -

      @m[0] * @m[6] * @m[15] -
      @m[2] * @m[7] * @m[12] -
      @m[3] * @m[4] * @m[14]
    end

    def b13
      @m[0] * @m[6] * @m[11] +
      @m[2] * @m[7] * @m[ 8] +
      @m[3] * @m[4] * @m[10] -

      @m[0] * @m[7] * @m[10] -
      @m[2] * @m[4] * @m[11] -
      @m[3] * @m[6] * @m[ 8]
    end

    def b20
      @m[4] * @m[ 9] * @m[15] +
      @m[5] * @m[11] * @m[12] +
      @m[7] * @m[ 8] * @m[13] -

      @m[4] * @m[11] * @m[13] -
      @m[5] * @m[ 8] * @m[15] -
      @m[7] * @m[ 9] * @m[12]
    end

    def b21
      @m[0] * @m[11] * @m[13] +
      @m[1] * @m[ 8] * @m[15] +
      @m[3] * @m[ 9] * @m[12] -

      @m[0] * @m[ 9] * @m[15] -
      @m[1] * @m[11] * @m[12] -
      @m[3] * @m[ 8] * @m[13]
    end

    def b22
      @m[0] * @m[5] * @m[15] +
      @m[1] * @m[7] * @m[12] +
      @m[3] * @m[4] * @m[13] -

      @m[0] * @m[7] * @m[13] -
      @m[1] * @m[4] * @m[15] -
      @m[3] * @m[5] * @m[12]
    end

    def b23
      @m[0] * @m[7] * @m[ 9] +
      @m[1] * @m[4] * @m[11] +
      @m[3] * @m[5] * @m[ 8] -

      @m[0] * @m[5] * @m[11] -
      @m[1] * @m[7] * @m[ 8] -
      @m[3] * @m[4] * @m[ 9]
    end

    def b30
      @m[4] * @m[10] * @m[13] +
      @m[5] * @m[ 8] * @m[14] +
      @m[6] * @m[ 9] * @m[12] -

      @m[4] * @m[ 9] * @m[14] -
      @m[5] * @m[10] * @m[12] -
      @m[6] * @m[ 8] * @m[13]
    end

    def b31
      @m[0] * @m[ 9] * @m[14] +
      @m[1] * @m[10] * @m[12] +
      @m[2] * @m[ 8] * @m[13] -

      @m[0] * @m[10] * @m[13] -
      @m[1] * @m[ 8] * @m[14] -
      @m[2] * @m[ 9] * @m[12]
    end

    def b32
      @m[0] * @m[6] * @m[13] +
      @m[1] * @m[4] * @m[14] +
      @m[2] * @m[5] * @m[12] -

      @m[0] * @m[5] * @m[14] -
      @m[1] * @m[6] * @m[12] -
      @m[2] * @m[4] * @m[13]
    end

    def b33
      @m[0] * @m[5] * @m[10] +
      @m[1] * @m[6] * @m[ 8] +
      @m[2] * @m[4] * @m[ 9] -

      @m[0] * @m[6] * @m[ 9] -
      @m[1] * @m[4] * @m[10] -
      @m[2] * @m[5] * @m[ 8]
    end

    # rubocop:enable all
  end
end
