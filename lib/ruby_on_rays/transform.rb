module RubyOnRays
  # Transform
  #
  # Transformations allow mappings from points to other points and from
  # vectors to other vecotrs.
  # The transformations given by Transform are guarnateed to be linear,
  # continuous, one-to-one, and invertible.
  class Transform
    # The identity matrix.
    IDENTITY = Matrix4x4.new([1.0, 0.0, 0.0, 0.0,
                              0.0, 1.0, 0.0, 0.0,
                              0.0, 0.0, 1.0, 0.0,
                              0.0, 0.0, 0.0, 1.0])
    private_constant :IDENTITY

    # @!attribute m [r] The transformation matrix.
    #   @return [Matrix4x4]
    attr_reader :m
    alias matrix m

    # @!attribute mi [r] The inverse of the transformation matrix.
    #   @return [Matrix4x4]
    attr_reader :mi
    alias inverse mi

    # Returns an identity transform.
    # @return [Transform]
    def self.identity
      @identity ||= Transform.new(IDENTITY, IDENTITY)
    end

    # Returns a translation transform.
    # @param dx [Float] The amount to translate in the x-direction.
    # @param dy [Float] The amount to translate in the y-direction.
    # @param dz [Float] The amount to translate in the z-direction.
    # @return [Transform]
    def self.translate(dx, dy, dz)
      m  = Matrix4x4.new([1.0, 0.0, 0.0, dx,
                          0.0, 1.0, 0.0, dy,
                          0.0, 0.0, 1.0, dz,
                          0.0, 0.0, 0.0, 1.0])

      mi = Matrix4x4.new([1.0, 0.0, 0.0, -dx,
                          0.0, 1.0, 0.0, -dy,
                          0.0, 0.0, 1.0, -dz,
                          0.0, 0.0, 0.0, 1.0])

      Transform.new(m, mi)
    end

    # Returns a scaling transfom.
    # @param sx [Float] The amount to scale in the x-direction.
    # @param sy [Float] The amount to scale in the y-direction.
    # @param sz [Float] The amount to scale in the z-direction.
    # @return [Transform]
    def self.scale(sx, sy, sz)
      m  = Matrix4x4.new([sx,  0.0, 0.0, 0.0,
                          0.0, sy,  0.0, 0.0,
                          0.0, 0.0, sz,  0.0,
                          0.0, 0.0, 0.0, 1.0])

      mi = Matrix4x4.new([1.0 / sx, 0.0, 0.0, 0.0,
                          0.0, 1.0 / sy, 0.0, 0.0,
                          0.0, 0.0, 1.0 / sz, 0.0,
                          0.0, 0.0, 0.0, 1.0])

      Transform.new(m, mi)
    end

    # Returns a transformation for rotating around the x-axis.
    # @param angle [Float] The angle to rotate around the x-axis IN RADIANS.
    # @return [Transform]
    def self.rotate_x(angle)
      s = Math.sin(angle)
      c = Math.cos(angle)

      m  = Matrix4x4.new([1.0, 0.0, 0.0, 0.0,
                          0.0, c,   -s,  0.0,
                          0.0, s,   c,   0.0,
                          0.0, 0.0, 0.0, 1.0])

      mi = Matrix4x4.new([1.0, 0.0, 0.0, 0.0,
                          0.0, c,   s,   0.0,
                          0.0, -s,  0.0, 0.0,
                          0.0, 0.0, 0.0, 1.0])

      Transform.new(m, mi)
    end

    # Returns a transformation for rotating around the y-axis.
    # @param angle [Float] The angle to rotate around the y-axis IN RADIANS.
    # @return [Transform]
    def self.rotate_y(angle)
      s = Math.sin(angle)
      c = Math.cos(angle)

      m  = Matrix4x4.new([c,   0.0, s,   0.0,
                          0.0, 1.0, 0.0, 0.0,
                          -s,  0.0, c,   0.0,
                          0.0, 0.0, 0.0, 1.0])

      mi = Matrix4x4.new([c,   0.0, -s,  0.0,
                          0.0, 1.0, 0.0, 0.0,
                          s,   0.0, c,   0.0,
                          0.0, 0.0, 0.0, 1.0])

      Transform.new(m, mi)
    end

    # Returns a transformation for rotating around the z-axis.
    # @param angle [Float] The angle to rotate around the z-axis IN RADIANS.
    # @return [Transform]
    def self.rotate_z(angle)
      s = Math.sin(angle)
      c = Math.cos(angle)

      m  = Matrix4x4.new([c,   -s,  0.0, 0.0,
                          s,   c,   0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.0, 0.0, 0.0, 1.0])

      mi = Matrix4x4.new([c,   s,   0.0, 0.0,
                          -s,  c,   0.0, 0.0,
                          0.0, 0.0, 1.0, 0.0,
                          0.0, 0.0, 0.0, 1.0])

      Transform.new(m, mi)
    end

    # Returns a tranformation for rotating around an arbitrary axis.
    # @param angle [Float] The angle to rotate around the axis IN RADIANS.
    # @return [Transform]
    def self.rotate(angle, axis)
      a = axis.normalize
      s = Math.sin(angle)
      c = Math.cos(angle)

      elements = [
        # Row 0
        a.x * a.x + (1.0 - a.x * a.x) * c,
        a.x * a.y * (1.0 - c) - a.z * s,
        a.x * a.z * (1.0 - c) + a.y * s,
        0.0,

        # Row 1
        a.x * a.y + (1.0 - c) + a.z * s,
        a.y * a.y + (1.0 - a.y * a.y) * c,
        a.y * a.z * (1.0 - c) - a.x * s,
        0.0,

        # Row 2
        a.x * a.z * (1.0 - c) - a.y * s,
        a.y * a.z * (1.0 - c) - a.x * s,
        a.z * a.z * (1.0 - a.z * a.z) * c,
        0.0,

        # Row 3
        0.0, 0.0, 0.0, 1.0
      ]

      m  = Matrix.new(elements)
      mi = m.transpose
      Transform.new(m, mi)
    end

    # Returns the transformation necessary to rotate a viewer such that it
    # points towards an object while maintaining the current "up" direction.
    # @param p_object [Point3] The position to put in view.
    # @param p_viewer [Point3] The position of the viewer.
    # @param up [Vector3] The up vector of the viewer.
    def self.look_at(p_object, p_viewer, up)
      dir  = (p_object - p_viewer).normalize
      left = up.normalize.cross(dir).normalize
      up   = dir.cross left

      mi = Matrix.new([left.x, up.x, dir.x, p_viewer.x,
                       left.y, up.y, dir.y, p_viewer.x,
                       lefy.z, up.z, dir.z, p_viewer.x,
                       0.0,    0.0,  0.0,   1.0])
      m  = mi.inverse

      Transform.new(m, mi)
    end

    # Returns the inverse transform.
    # @note This is different from {#inverse}, which returns the inverse matrix.
    # @param transform [Transform]
    # @return [Transform]
    def self.invert(transform)
      Transform.new(transform.mi.dup, transform.m.dup)
    end

    # @overload initialize() Returns the identity matrix.
    #   @return [Transform]
    # @overload initialize(m) Creates a new transform from the given matrix.
    #   @param m [Matrix4x4] The matrix that describes the transform.
    #   Must be invertible.
    # @overload initialize(m, mi) Creates new trasform from given matrix and
    #   its inverse.
    #   @param m [Matrix4x4] The matrix that describes the transform.
    #   @param mi [Matrix4x4] The inverse of m.
    def initialize(*args)
      case args.size
      when 0
        @m  = IDENTITY
        @mi = IDENTITY
      when 1
        @m  = args[0]
        @mi = args[0].inverse
      when 2
        @m  = args[0]
        @mi = args[1]
      else
        fail ArgumentError, "Wrong number of arguments (#{args.size} for 0..2)."
      end
    end

    # Are two transforms equal?
    # @param other [Transform, Object]
    # @return [Boolean] false if other is not a transform or has different
    #   elements, true otherwise.
    def ==(other)
      return false unless other.is_a? Transform
      @m == other.m && @mi == other.mi
    end

    # Is this transform the identity?
    # @return [Boolean]
    def identity?
      @m == @mi
    end

    # @overload transform(p) Transforms a point
    #   @param p [Point3]
    #   @return [Point3] A new point.
    # @overload transform(v) Transforms a vector
    #   @param v [Vector3]
    #   @return [Vector3] A new vector.
    # @overload transform(n) Transforms a normal.
    #   @param n [Normal3]
    #   @return [Normal3] A new normal.
    def transform(arg)
      case arg
      when Point3
        transform_point(arg)
      when Vector3
        transform_vector(arg)
      when Normal3
        transform_normal(arg)
      when Ray3
        transform_ray(arg)
      else
        fail ArgumentError, "Wrong type (#{arg.type})."
      end
    end

    # Does this transform have any scaling factors?
    # @return [Boolean] True if the transform has any scaling factors, false
    #   otherwise.
    # @note Rounding errors may cause this to be insufficiently accurate at
    #   large scale differences.
    def scales?
      r = 0.9999..1.0001

      !r.cover?(transform_vector(Vector3.i).length_squared) &&
        !r.cover?(transform_vector(Vector3.j).length_squared) &&
        !r.cover?(transform_vector(Vector3.k).length_squared)
    end

    # Composes two transforms. The order of operations is important and are
    # left associative.
    # @param rhs [Transform] The transformation to follow
    def mul(rhs)
      m = @m.mul(rhs.m)
      mi = rhs.mi.mul(m)

      Transform.new(m, mi)
    end

    # Checks if the transformation swaps the handedness of the local coordiante
    # system.
    # @return [Boolean]
    def swaps_handedness?
      # Swaps if the determinant of the upper-left 3x3 matrix is negative!
      det33 = @m[0, 0] * (@m[1, 1] * @m[2, 2] - @m[1, 2] * @m[2, 1]) -
              @m[0, 1] * (@m[1, 0] * @m[2, 2] - @m[1, 2] * @m[2, 0]) +
              @m[0, 2] * (@m[1, 0] * @m[2, 1] - @m[1, 1] * @m[2, 0])

      det33 < 0.0
    end

    # Transforms a point.
    # @param p [Point3]
    # @return [Point3] A new point.
    def transform_point(p)
      x = @m[0, 0] * p.x + @m[0, 1] * p.y + @m[0, 2] * p.z +  @m[0, 3]
      y = @m[1, 0] * p.x + @m[1, 1] * p.y + @m[1, 2] * p.z +  @m[1, 3]
      z = @m[2, 0] * p.x + @m[2, 1] * p.y + @m[2, 2] * p.z +  @m[2, 3]
      w = @m[3, 0] * p.x + @m[3, 1] * p.y + @m[3, 2] * p.z +  @m[3, 3]

      f = 1.0 / w
      Point3.new(f * x, f * y, f * z)
    end

    # Transforms a vector.
    # @param v [Vector3]
    # @return [Vector3] A new vector.
    def transform_vector(v)
      x = @m[0, 0] * v.x + @m[0, 1] * v.y + @m[0, 2] * v.z
      y = @m[1, 0] * v.x + @m[1, 1] * v.y + @m[1, 2] * v.z
      z = @m[2, 0] * v.x + @m[2, 1] * v.y + @m[2, 2] * v.z

      Vector3.new(x, y, z)
    end

    # Transforms a normal.
    # @param n [Normal3]
    # @return [Normal3] A new normal.
    def transform_normal(n)
      # Use the transpose of the inverse matrix.
      # No need to actually call #transpose, just index differently.
      x = @mi[0, 0] * n.x + @mi[1, 0] * n.y + @mi[2, 0] * n.z
      y = @mi[0, 1] * n.x + @mi[1, 1] * n.y + @mi[2, 1] * n.z
      z = @mi[0, 2] * n.x + @mi[1, 2] * n.y + @mi[2, 2] * n.z

      Normal3.new(x, y, z)
    end

    # Transforms a ray.
    # @param r [Ray3]
    # @return [Ray3] A new ray (does NOT increase recursion depth).
    def transform_ray(r)
      o = transform_point(r.o)
      d = transform_vector(r.d)

      Ray3.new(o, d, tmin: r.tmin, tmax: r.tmax, depth: r.depth)
    end
  end
end
