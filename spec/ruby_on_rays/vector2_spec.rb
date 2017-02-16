require 'spec_helper'

module RubyOnRays
  describe Vector2 do
    describe '.i' do
      let(:i) { Vector2.i }

      it 'returns a new Vector2' do
        expect(i).to be_a Vector2
        expect(i).to_not be Vector2.i
      end

      it 'returns a unit vector in the x-direction' do
        expect(i.x).to eq 1.0
        expect(i.y).to eq 0.0
      end

      it 'returns a normalized vector' do
        expect(i.length).to be_within(0.001).of 1.0
      end
    end

    describe '.j' do
      let(:j) { Vector2.j }

      it 'returns a new Vector2' do
        expect(j).to be_a Vector2
        expect(j).to_not be Vector2.j
      end

      it 'returns a unit vector in the y-direction' do
        expect(j.x).to eq 0.0
        expect(j.y).to eq 1.0
      end

      it 'returns a normalized vector' do
        expect(j.length).to be_within(0.001).of 1.0
      end
    end

    describe '.new' do
      context 'given an x- and a y-direction' do
        let(:x) { rand(-100.0..100.0) }
        let(:y) { rand(-100.0..100.0) }
        let(:v) { Vector2.new(x, y) }

        it 'returns a vector2 with the given components' do
          expect(v.x).to eq x
          expect(v.y).to eq y
        end
      end
    end

    describe '#-@' do
      let(:v) { Vector2.new(2.0, 3.0) }
      let(:u) { -v }

      it 'returns a new Vector2' do
        expect(u).to be_a Vector2
        expect(u).to_not be v
      end

      it 'returns a vector in the opposite direction' do
        expect(u.x).to be_within(0.001).of(-2.0)
        expect(u.y).to be_within(0.001).of(-3.0)
      end
    end

    describe '#add' do
      context 'given a Vector2' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:sum) { lhs.add(rhs) }

        it 'returns a new Vector2' do
          expect(sum).to be_a Vector2
          expect(sum).to_not be lhs
          expect(sum).to_not be rhs
        end

        it 'returns the vector sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#add!' do
      context 'given a Vector2' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:sum) { lhs.add!(rhs) }

        it 'returns self' do
          expect(sum).to be lhs
        end

        it 'returns the vector sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#sub' do
      context 'given a Vector2' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 5.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new Vector2' do
          expect(difference).to be_a Vector2
          expect(difference).to_not be lhs
          expect(difference).to_not be rhs
        end

        it 'returns the vector difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
        end
      end
    end

    describe '#sub!' do
      context 'given a Vector2' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 5.0) }
        let(:difference) { lhs.sub!(rhs) }

        it 'returns self' do
          expect(difference).to be lhs
        end

        it 'returns the vector difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
        end
      end
    end

    describe '#mul' do
      context 'given a Float' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul(rhs) }

        it 'returns a new Vector2' do
          expect(product).to be_a Vector2
          expect(product).to_not be lhs
        end

        it 'returns the vector-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
        end
      end
    end

    describe '#mul!' do
      context 'given a Float' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul!(rhs) }

        it 'mutates self' do
          expect(product).to be lhs
        end

        it 'returns the vector-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
        end
      end
    end

    describe '#div' do
      context 'given a Float' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div(rhs) }

        it 'returns a new Vector2' do
          expect(quotient).to be_a Vector2
          expect(quotient).to_not be lhs
        end

        it 'returns the vector-scalar quotient' do
          expect(quotient.x).to be_within(0.001).of 0.5
          expect(quotient.y).to be_within(0.001).of 1.0
        end
      end
    end

    describe '#div!' do
      context 'given a Float' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div!(rhs) }

        it 'mutates self' do
          expect(quotient).to be lhs
        end

        it 'returns the vector-scalar quotient' do
          expect(quotient.x).to be_within(0.001).of 0.5
          expect(quotient.y).to be_within(0.001).of 1.0
        end
      end
    end

    describe '#dot' do
      context 'given a Vector2' do
        let(:lhs) { Vector2.new(1.0, 2.0) }
        let(:rhs) { Vector2.new(3.0, 4.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 11.0
        end
      end
    end

    describe '#length' do
      context 'called on a unit vector' do
        let(:v) { [Vector2.i, Vector2.j].sample }

        it 'returns 1.0' do
          expect(v.length).to be_within(0.001).of 1.0
        end
      end

      context 'called on a vector' do
        let(:v) { Vector2.new(1.0, 1.0) }

        it 'returns the length' do
          expect(v.length).to be_within(0.001).of Math.sqrt(2.0)
        end
      end
    end

    describe '#length_squared' do
      context 'called on a unit vector' do
        let(:v) { [Vector2.i, Vector2.j].sample }

        it 'returns 1.0' do
          expect(v.length_squared).to be_within(0.001).of 1.0
        end
      end

      context 'called on a vector' do
        let(:v) { Vector2.new(1.0, 1.0) }

        it 'returns the length squared' do
          expect(v.length_squared).to be_within(0.001).of 2.0
        end
      end
    end

    describe '#normalize' do
      let(:v) { Vector2.new(2.0, 2.0) }
      let(:vn) { v.normalize }

      it 'returns a new unit vector' do
        expect(vn).to be_a Vector2
        expect(vn).to_not be v
        expect(vn.length).to be_within(0.001).of 1.0
      end

      it 'returns a vector pointing in the same direction' do
        expect(vn.x).to be_within(0.001).of(1.0 / Math.sqrt(2.0))
        expect(vn.y).to be_within(0.001).of(1.0 / Math.sqrt(2.0))
      end
    end
  end
end
