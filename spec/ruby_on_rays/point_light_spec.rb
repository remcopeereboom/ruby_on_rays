require 'spec_helper'

module RubyOnRays
  describe PointLight do
    describe '.new' do
      context 'given a position' do
        let(:position) { Point3.new(rand, rand, rand) }
        let(:light) { PointLight.new(position) }

        it 'returns a white PointLight at the given position' do
          expect(light).to be_a PointLight
          expect(light.p).to eq position
          expect(light.c).to eq Color.new(1.0, 1.0, 1.0)
        end
      end

      context 'given a position and a color' do
        let(:position) { Point3.new(rand, rand, rand) }
        let(:color) { Color.new(rand, rand, rand) }
        let(:light) { PointLight.new(position, color: color) }

        it 'returns a PointLight at the given position' do
          expect(light).to be_a PointLight
          expect(light.p).to eq position
        end

        it 'returns a PointLight with the given color' do
          expect(light.c).to eq color
        end
      end
    end
  end
end
