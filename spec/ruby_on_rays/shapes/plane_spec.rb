require 'spec_helper'

module RubyOnRays
  describe Plane do
    describe '.xy' do
      let(:plane) { Plane.xy }

      it 'returns a plane with a unit normal in the positive z-direction' do
        expect(plane.n).to eq Normal3.new(0.0, 0.0, 1.0)
      end
    end

    describe '.xz' do
      let(:plane) { Plane.xz }

      it 'returns a plane with a unit normal in the positive y-direction' do
        expect(plane.n).to eq Normal3.new(0.0, 1.0, 0.0)
      end
    end

    describe '.yz' do
      let(:plane) { Plane.yz }

      it 'returns a plane with a unit normal in the positive x-direction' do
        expect(plane.n).to eq Normal3.new(1.0, 0.0, 0.0)
      end
    end

    describe '.new' do
      context 'given a point on the surface a surface normal' do
        let(:point) { Point3.new(1.0, 2.0, 3.0) }
        let(:normal) { Normal3.new(1.0, 2.0, 3.0) }
        let(:plane) { Plane.new(point, normal) }

        it 'returns a plane' do
          expect(plane).to be_a Plane
        end
      end
    end
  end
end
