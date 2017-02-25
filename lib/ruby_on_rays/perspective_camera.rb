module RubyOnRays
  # PerspectiveCamera
  class PerspectiveCamera
    # Initializes a new camera.
    def initialize(width, height)
      @width = width
      @height = height
      @film = ChunkyPNG::Image.new(width, height, ChunkyPNG::Color::TRANSPARENT)

      # Cache:
      @dx = 2.0 / @width
      @dy = 2.0 / @height
      @offset_x = -1.0 + 0.5 * @dx
      @offset_y = -1.0 + 0.5 * @dy
    end

    # Yields image samples with their corresponding rays.
    # @yield [<Point2, Ray3>]
    # @return [Enumerator<:each_with_ray>] if no block given.
    # @return [self] f a block is given.
    def each_sample_with_ray
      unless block_given?
        return enum_for(:each_sample_with_ray) { @width * @height }
      end

      (0...@height).each do |y|
        (0...@width).each do |x|
          p_film = Point2.new(x, y)
          yield p_film, ray_for_point(p_film)
        end
      end

      self
    end

    # Stores the image to file.
    # @param relative_path [String] The destination path relative to the
    #   current working directory.
    # @return [void]
    def save(relative_path = 'tmp/foo.png')
      puts "Saving image to #{Dir.pwd}/#{relative_path}"
      @film.save(relative_path)
    end

    # Gets the color at the given pixel position.
    # @param p [Point2] Must lie on the film!
    # @return [Color]
    def [](p)
      chunky_to_color(@film[p.x, @height - 1 - p.y])
    end

    # Sets the color at the given pixel position.
    # @param p [Point2] Must lie on the film!
    # @param color [Color]
    # @return [void]
    def []=(p, color)
      @film[p.x, @height - 1 - p.y] = color_to_chunky(color)
    end

    private

    # Converts a ChunkyPNG::Color to a RubyOnRays::Color
    # @param chunky_color [ChunkyPNG::Color]
    # @return [RubyOnRays::Color]
    def chunky_to_color(chunky_color)
      r = chunky_color.r / 255.0
      g = chunky_color.g / 255.0
      b = chunky_color.b / 255.0

      Color.new(r, g, b)
    end

    # Converts a RubyOnRays::Color to a ChunkyPNG::Color
    # @param color [RubyOnRays::Color]
    # @return [ChunkyPNG::Color]
    def color_to_chunky(color)
      r = (color.r * 255.0).to_i
      g = (color.g * 255.0).to_i
      b = (color.b * 255.0).to_i

      ChunkyPNG::Color.rgb(r, g, b)
    end

    # Returns a ray for the given film point.
    # @param p_film [Point2]
    # @return [Ray3]
    def ray_for_point(p_film)
      o = Point3.origin
      d = Vector3.new(@offset_x + p_film.x * @dx,
                      @offset_y + p_film.y * @dy,
                      1.0)
      Ray3.new(o, d)
    end
  end
end
