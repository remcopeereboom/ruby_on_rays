module RubyOnRays
  # PointLight
  #
  # An omni-directional light located at a single point.
  class PointLight
    # @!attribute p [r] The position of the light.
    #   @return [Point3]
    attr_reader :p
    alias position p

    # @!attribute c [r] The color of the light.
    #   @return [Color]
    attr_reader :c
    alias color c

    def initialize(position, color: Color.new(1.0, 1.0, 1.0))
      @p = position
      @c = color
    end
  end
end
