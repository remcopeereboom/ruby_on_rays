require 'spec_helper'

module RubyOnRays
  describe Scene do
    describe '.new' do
      let(:scene) { Scene.new }

      it 'returns an empty Scene' do
        expect(scene.shapes).to be_empty
        expect(scene.lights).to be_empty
      end
    end

    describe '#add_light' do
      context 'given a light not in the scene' do
        let(:light) { PointLight.new(Point3.origin) }
        let(:scene) { Scene.new }

        it 'adds a light to the list of shapes' do
          nr_before = scene.lights.size

          scene.add_light(light)

          expect(scene.lights.size).to eq nr_before + 1
          expect(scene.lights).to include light
        end

        it 'returns the scene (self)' do
          expect(scene.add_light(light)).to be scene
        end
      end
      context 'given a light already in the scene' do
        let(:light) { PointLight.new(Point3.origin) }
        let(:scene) do
          s = Scene.new
          s.add_light(light)
          s
        end

        it 'does not add the duplicate to the scene' do
          nr_before = scene.lights.size

          scene.add_light(light)

          expect(scene.lights.size).to eq nr_before
          expect(scene.lights).to include light
        end

        it 'returns the scene (self)' do
          expect(scene.add_light(light)).to be scene
        end
      end
    end

    describe '#add_shape' do
      context 'given a shape not in the scene' do
        let(:shape) { Sphere.new }
        let(:scene) { Scene.new }

        it 'adds the shape to the scene' do
          nr_before = scene.shapes.size

          scene.add_shape(shape)

          expect(scene.shapes.size).to eq nr_before + 1
          expect(scene.shapes).to include shape
        end

        it 'returns the scene (self)' do
          expect(scene.add_shape(shape)).to be scene
        end
      end

      context 'given a shape already in the set' do
        let(:shape) { Sphere.new }
        let(:scene) do
          s = Scene.new
          s.add_shape(shape)
          s
        end

        it 'does not add the duplicate to the scene' do
          nr_before = scene.shapes.size

          scene.add_shape(shape)

          expect(scene.shapes.size).to eq nr_before
          expect(scene.shapes).to include shape
        end

        it 'returns the scene (self)' do
          expect(scene.add_shape(shape)).to be scene
        end
      end
    end
  end
end
