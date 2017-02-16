require 'spec_helper'

module RubyOnRays
  describe Ray3 do
    describe '.new' do
      context 'given an origin and a direction' do
        let(:origin) { Point3.new(1.0, 2.0, 3.0) }
        let(:direction) { Vector3.new(4.0, 5.0, 6.0) }
        let(:ray) { Ray3.new(origin, direction) }

        it 'sets the origin and direction to the parameters given' do
          expect(ray.o).to eq origin
          expect(ray.d).to eq direction
        end

        it 'sets tmin to 0.0' do
          expect(ray.tmin).to eq 0.0
        end

        it 'sets tmax to Float::INFINITY' do
          expect(ray.tmax).to eq Float::INFINITY
        end

        it 'sets depth to 0' do
          expect(ray.depth).to eq 0
        end
      end
    end

    describe '#[]' do
      context 'given a float between tmin and tmax' do
        let(:origin) { Point3.origin }
        let(:direction) { Vector3.i }
        let(:ray) { Ray3.new(origin, direction) }
        let(:t) { 10.0 }
        let(:pt) { ray[t] }

        it 'returns the point on the line at position "t" ' do
          expect(pt).to be_a Point3
          expect(pt.x).to be_within(0.001).of 10.0
          expect(pt.y).to be_within(0.001).of 0.0
        end
      end
    end
  end
end
