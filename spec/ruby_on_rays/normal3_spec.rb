require 'spec_helper'

module RubyOnRays
  describe Normal3 do
    describe '.new' do
      context 'given an x-, y- and z-direction' do
        let(:x) { rand(-100.0..100.0) }
        let(:y) { rand(-100.0..100.0) }
        let(:z) { rand(-100.0..100.0) }
        let(:n) { Normal3.new(x, y, z) }

        it 'returns a Normal3 pointing in the given direction' do
          expect(n.x).to eq x
          expect(n.y).to eq y
          expect(n.z).to eq z
        end
      end
    end

    describe '#add' do
      context 'given a Normal3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Normal3.new(3.0, 4.0, 5.0) }
        let(:sum) { lhs.add(rhs) }

        it 'returns a new Normal3' do
          expect(sum).to be_a Normal3
          expect(sum).to_not be lhs
          expect(sum).to_not be rhs
        end

        it 'returns the normal-normal sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
          expect(sum.z).to be_within(0.001).of 8.0
        end
      end
    end

    describe '#add!' do
      context 'given a Normal3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Normal3.new(3.0, 4.0, 5.0) }
        let(:sum) { lhs.add!(rhs) }

        it 'returns self' do
          expect(sum).to be lhs
        end

        it 'returns the normal-normal sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
          expect(sum.z).to be_within(0.001).of 8.0
        end
      end
    end

    describe '#sub' do
      context 'given a Normal3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Normal3.new(3.0, 5.0, 7.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new Normal3' do
          expect(difference).to be_a Normal3
          expect(difference).to_not be lhs
          expect(difference).to_not be rhs
        end

        it 'returns the normal-normal difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
          expect(difference.z).to be_within(0.001).of(-4.0)
        end
      end
    end

    describe '#sub!' do
      context 'given a Normal3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 5.0, 7.0) }
        let(:difference) { lhs.sub!(rhs) }

        it 'returns self' do
          expect(difference).to be lhs
        end

        it 'returns the normal-normal difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
          expect(difference.z).to be_within(0.001).of(-4.0)
        end
      end
    end

    describe '#mul' do
      context 'given a Float' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul(rhs) }

        it 'returns a new Normal3' do
          expect(product).to be_a Normal3
          expect(product).to_not be lhs
        end

        it 'returns the normal-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
          expect(product.z).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#mul!' do
      context 'given a Float' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul!(rhs) }

        it 'mutates self' do
          expect(product).to be lhs
        end

        it 'returns the normal-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
          expect(product.z).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#div' do
      context 'given a Float' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div(rhs) }

        it 'returns a new Normal3' do
          expect(quotient).to be_a Normal3
          expect(quotient).to_not be lhs
        end

        it 'returns the vector-scalar quotient' do
          expect(quotient.x).to be_within(0.001).of 0.5
          expect(quotient.y).to be_within(0.001).of 1.0
          expect(quotient.z).to be_within(0.001).of 1.5
        end
      end
    end

    describe '#div!' do
      context 'given a Float' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div!(rhs) }

        it 'mutates self' do
          expect(quotient).to be lhs
        end

        it 'returns the normal-scalar quotient' do
          expect(quotient.x).to be_within(0.001).of 0.5
          expect(quotient.y).to be_within(0.001).of 1.0
          expect(quotient.z).to be_within(0.001).of 1.5
        end
      end
    end

    describe '#dot' do
      context 'given a Point3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Point3.new(3.0, 4.0, 5.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 26.0
        end
      end

      context 'given a Vector3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 4.0, 5.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 26.0
        end
      end

      context 'given a Normal3' do
        let(:lhs) { Normal3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Normal3.new(3.0, 4.0, 5.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 26.0
        end
      end
    end

    describe '#length' do
      let(:n) { Normal3.new(1.0, 1.0, 1.0) }

      it 'returns the length' do
        expect(n.length).to be_within(0.001).of Math.sqrt(3.0)
      end
    end

    describe '#length_squared' do
      let(:n) { Normal3.new(1.0, 1.0, 1.0) }

      it 'returns the length squared' do
        expect(n.length_squared).to be_within(0.001).of 3.0
      end
    end

    describe '#normalize' do
      let(:n) { Normal3.new(2.0, 2.0, 2.0) }
      let(:nn) { n.normalize }

      it 'returns a new unit normal' do
        expect(nn).to be_a Normal3
        expect(nn).to_not be n
        expect(nn.length).to be_within(0.001).of 1.0
      end

      it 'returns a vector pointing in the same direction' do
        expect(nn.x).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
        expect(nn.y).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
        expect(nn.z).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
      end
    end

    describe '#to_p' do
      let(:n) { Normal3.new(1.0, 2.0, 3.0) }
      let(:p) { n.to_p }

      it 'returns a Point3 with the same components' do
        expect(p).to be_a Point3

        expect(p.x).to eq n.x
        expect(p.y).to eq n.y
        expect(p.z).to eq n.z
      end
    end

    describe '#to_v' do
      let(:n) { Normal3.new(1.0, 2.0, 3.0) }
      let(:v) { n.to_v }

      it 'returns a Vector3 pointing in the same direction' do
        expect(v).to be_a Vector3

        expect(v.x).to eq n.x
        expect(v.y).to eq n.y
        expect(v.z).to eq n.z
      end
    end

    describe '#to_n' do
      let(:n) { Normal3.new(1.0, 2.0, 3.0) }
      let(:n_new) { n.to_n }

      it 'returns a copy of the normal' do
        expect(n_new).to be_a Normal3
        expect(n_new).to eq n
        expect(n_new).to_not be n
      end
    end
  end
end
