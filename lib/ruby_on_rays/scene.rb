module RubyOnRays
  # Scene
  #
  # A scene is a container for the geometry, lighting and camera.
  class Scene
    # @!attribute [r] shapes
    #   @return [Enumerable<Shape>]
    # @!attribute [r] lights
    #   @return [Enumerable<Light>]
    attr_reader :shapes, :lights

    # Initializes an empty scene.
    def initialize
      @shapes = Set.new
      @lights = Set.new
    end

    # Adds a shape to the set of shapes.
    # @param shape [Shape]
    # @return [self]
    def add_shape(shape)
      @shapes.add(shape)
      self
    end

    # Adds a light to the set of lights.
    # @param light [Light]
    # @return [self]
    def add_light(light)
      @lights.add(light)
      self
    end
  end
end
