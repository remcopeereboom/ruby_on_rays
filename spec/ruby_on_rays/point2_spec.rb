require 'spec_helper'

module RubyOnRays
  describe Point2 do
    describe '.origin' do
      let(:origin) { Point2.origin }

      it 'returns a Point2' do
        expect(origin).to be_a Point2
      end

      it 'returns unique instances' do
        expect(origin).to_not be Point2.origin
      end

      it 'returns a new point p(0, 0)' do
        expect(origin.x).to eq 0.0
        expect(origin.y).to eq 0.0
      end
    end

    describe '.new' do
      context 'given an x- and a y-coordinate' do
        let(:x) { rand(-100.0..100.0) }
        let(:y) { rand(-100.0..100.0) }
        let(:p) { Point2.new(x, y) }

        it 'returns a Point2' do
          expect(p).to be_a Point2
        end

        it 'sets the coordinates' do
          expect(p.x).to eq x
          expect(p.y).to eq y
        end
      end
    end

    describe '#add' do
      context 'given a Vector2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:sum) { lhs.add(rhs) }

        it 'returns the translation by the vector' do
          expect(sum).to be_a Point2
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
        end

        it 'does not mutate self' do
          expect(lhs.x).to eq 1.0
          expect(lhs.y).to eq 2.0
        end
      end
    end

    describe '#add!' do
      context 'given a Vector2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:sum) { lhs.add!(rhs) }

        it 'returns the translation by the vector' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
        end

        it 'return self' do
          expect(sum).to be lhs
        end
      end
    end

    describe '#sub' do
      context 'given a Vector2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 5.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new Point2' do
          expect(difference).to be_a Point2
          expect(difference).to_not be lhs
        end

        it 'returns the translation by the vector' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
        end
      end

      context 'given a Point2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Point2.new(3.0, 5.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new Vector2' do
          expect(difference).to be_a Vector2
          expect(difference).to_not be rhs
        end

        it 'returns the vector rhs to lhs' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
        end
      end
    end

    describe '#sub!' do
      context 'given a Vector2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 5.0) }
        let(:difference) { lhs.sub!(rhs) }

        it 'returns the translation by the vector' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
        end

        it 'return self' do
          expect(difference).to be lhs
        end
      end
    end

    describe '#dot' do
      context 'given a Point2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Point2.new(3.0, 4.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 11.0
        end
      end

      context 'given a Vector2' do
        let(:lhs) { Point2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 11.0
        end
      end
    end

    describe '#distance_to' do
      context 'given self' do
        let(:a) { Point2.new(3.0, 4.0) }
        let(:b) { a }
        let(:distance) { a.distance_to(b) }

        it 'returns 0' do
          expect(distance).to eq 0.0
        end
      end

      context 'given a point' do
        let(:a) { Point2.new(1.0, 0.0) }
        let(:b) { Point2.new(0.0, 1.0) }
        let(:distance) { a.distance_to(b) }

        it 'returns the distance between the two points' do
          expect(distance).to be_within(0.001).of Math.sqrt(2.0)
        end
      end
    end

    describe '#distance_squared_to' do
      context 'given self' do
        let(:a) { Point2.new(3.0, 4.0) }
        let(:b) { a }
        let(:distance2) { a.distance_squared_to(b) }

        it 'returns 0' do
          expect(distance2).to eq 0.0
        end
      end

      context 'given a point' do
        let(:a) { Point2.new(1.0, 0.0) }
        let(:b) { Point2.new(0.0, 1.0) }
        let(:distance2) { a.distance_squared_to(b) }

        it 'returns the distance between the two points' do
          expect(distance2).to be_within(0.001).of 2.0
        end
      end
    end

    describe '#to_p' do
      let(:p) { Point2.new(1.0, 2.0) }
      let(:p_new) { p.to_p }

      it 'returns a copy of the point' do
        expect(p_new).to be_a Point2
        expect(p_new).to eq p
        expect(p_new).to_not be p
      end
    end

    describe '#to_v' do
      let(:p) { Point2.new(1.0, 2.0) }
      let(:v) { p.to_v }

      it 'returns a Vector2 with the same components' do
        expect(p).to be_a Point2
        expect(p.x).to eq v.x
        expect(p.y).to eq v.y
      end
    end
  end
end
