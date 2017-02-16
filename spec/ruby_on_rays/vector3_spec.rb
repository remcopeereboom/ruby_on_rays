require 'spec_helper'

module RubyOnRays
  describe Vector3 do
    describe '.i' do
      let(:i) { Vector3.i }

      it 'returns a new Vecto3r' do
        expect(i).to be_a Vector3
        expect(i).to_not be Vector3.i
      end

      it 'returns a unit vector in the x-direction' do
        expect(i.x).to eq 1.0
        expect(i.y).to eq 0.0
        expect(i.z).to eq 0.0
      end

      it 'returns a normalized vector' do
        expect(i.length).to be_within(0.001).of 1.0
      end
    end

    describe '.j' do
      let(:j) { Vector3.j }

      it 'returns a new Vector3' do
        expect(j).to be_a Vector3
        expect(j).to_not be Vector3.j
      end

      it 'returns a unit vector in the y-direction' do
        expect(j.x).to eq 0.0
        expect(j.y).to eq 1.0
        expect(j.z).to eq 0.0
      end

      it 'returns a normalized vector' do
        expect(j.length).to be_within(0.001).of 1.0
      end
    end

    describe '.k' do
      let(:k) { Vector3.k }

      it 'returns a new Vector3' do
        expect(k).to be_a Vector3
        expect(k).to_not be Vector3.k
      end

      it 'returns a unit vector in the z-direction' do
        expect(k.x).to eq 0.0
        expect(k.y).to eq 0.0
        expect(k.z).to eq 1.0
      end

      it 'returns a normalized vector' do
        expect(k.length).to be_within(0.001).of 1.0
      end
    end

    describe '.new' do
      context 'given an x- and a y-direction' do
        let(:x) { rand(-100.0..100.0) }
        let(:y) { rand(-100.0..100.0) }
        let(:z) { rand(-100.0..100.0) }
        let(:v) { Vector3.new(x, y, z) }

        it 'returns a vector3 with the given components' do
          expect(v.x).to eq x
          expect(v.y).to eq y
          expect(v.z).to eq z
        end
      end
    end

    describe '#-@' do
      let(:v) { Vector3.new(2.0, 3.0, -4.0) }
      let(:u) { -v }

      it 'returns a new Vector3' do
        expect(u).to be_a Vector3
        expect(u).to_not be v
      end

      it 'returns a vector in the opposite direction' do
        expect(u.x).to be_within(0.001).of(-2.0)
        expect(u.y).to be_within(0.001).of(-3.0)
        expect(u.z).to be_within(0.001).of(4.0)
      end
    end

    describe '#add' do
      context 'given a Vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 4.0, 5.0) }
        let(:sum) { lhs.add(rhs) }

        it 'returns a new Vector3' do
          expect(sum).to be_a Vector3
          expect(sum).to_not be lhs
          expect(sum).to_not be rhs
        end

        it 'returns the vector sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
          expect(sum.z).to be_within(0.001).of 8.0
        end
      end
    end

    describe '#add!' do
      context 'given a Vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 4.0, 5.0) }
        let(:sum) { lhs.add!(rhs) }

        it 'returns self' do
          expect(sum).to be lhs
        end

        it 'returns the vector sum' do
          expect(sum.x).to be_within(0.001).of 4.0
          expect(sum.y).to be_within(0.001).of 6.0
          expect(sum.z).to be_within(0.001).of 8.0
        end
      end
    end

    describe '#sub' do
      context 'given a Vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 5.0, 7.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new Vector3' do
          expect(difference).to be_a Vector3
          expect(difference).to_not be lhs
          expect(difference).to_not be rhs
        end

        it 'returns the vector difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
          expect(difference.z).to be_within(0.001).of(-4.0)
        end
      end
    end

    describe '#sub!' do
      context 'given a Vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 5.0, 7.0) }
        let(:difference) { lhs.sub!(rhs) }

        it 'returns self' do
          expect(difference).to be lhs
        end

        it 'returns the vector difference' do
          expect(difference.x).to be_within(0.001).of(-2.0)
          expect(difference.y).to be_within(0.001).of(-3.0)
          expect(difference.z).to be_within(0.001).of(-4.0)
        end
      end
    end

    describe '#mul' do
      context 'given a Float' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul(rhs) }

        it 'returns a new Vector3' do
          expect(product).to be_a Vector3
          expect(product).to_not be lhs
        end

        it 'returns the vector-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
          expect(product.z).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#mul!' do
      context 'given a Float' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul!(rhs) }

        it 'mutates self' do
          expect(product).to be lhs
        end

        it 'returns the vector-scalar product' do
          expect(product.x).to be_within(0.001).of 2.0
          expect(product.y).to be_within(0.001).of 4.0
          expect(product.z).to be_within(0.001).of 6.0
        end
      end
    end

    describe '#div' do
      context 'given a Float' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div(rhs) }

        it 'returns a new Vector3' do
          expect(quotient).to be_a Vector3
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
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div!(rhs) }

        it 'mutates self' do
          expect(quotient).to be lhs
        end

        it 'returns the vector-scalar quotient' do
          expect(quotient.x).to be_within(0.001).of 0.5
          expect(quotient.y).to be_within(0.001).of 1.0
          expect(quotient.z).to be_within(0.001).of 1.5
        end
      end
    end

    describe '#dot' do
      context 'given a Point3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Point3.new(3.0, 4.0, 5.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 26.0
        end
      end

      context 'given a Vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 4.0, 5.0) }
        let(:dot_product) { lhs.dot(rhs) }

        it 'returns the dot product' do
          expect(dot_product).to be_within(0.001).of 26.0
        end
      end
    end

    describe '#cross' do
      it 'assumes a right-handed coordinates system' do
        i = Vector3.i
        j = Vector3.j
        k = Vector3.k

        ij = i.cross(j)
        jk = j.cross(k)
        ki = k.cross(i)

        expect(ij.x).to be_within(0.001).of k.x
        expect(ij.x).to be_within(0.001).of k.x
        expect(ij.x).to be_within(0.001).of k.x

        expect(jk.x).to be_within(0.001).of i.x
        expect(jk.y).to be_within(0.001).of i.y
        expect(jk.z).to be_within(0.001).of i.z

        expect(ki.x).to be_within(0.001).of j.x
        expect(ki.y).to be_within(0.001).of j.y
        expect(ki.z).to be_within(0.001).of j.z
      end

      context 'given a vector3' do
        let(:lhs) { Vector3.new(1.0, 2.0, 3.0) }
        let(:rhs) { Vector3.new(3.0, 4.0, 5.0) }
        let(:cross) { lhs.cross(rhs) }

        it 'returns the cross product' do
          expect(cross.x).to be_within(0.001).of(-2.0)
          expect(cross.y).to be_within(0.001).of(4.0)
          expect(cross.z).to be_within(0.001).of(-2.0)
        end

        it 'returns a new Vector3' do
          expect(cross).to be_a Vector3
          expect(cross).to_not be lhs
          expect(cross).to_not be rhs
        end
      end
    end

    describe '#length' do
      context 'called on a unit vector' do
        let(:v) { [Vector3.i, Vector3.j, Vector3.k].sample }

        it 'returns 1.0' do
          expect(v.length).to be_within(0.001).of 1.0
        end
      end

      context 'called on a vector' do
        let(:v) { Vector3.new(1.0, 1.0, 1.0) }

        it 'returns the length' do
          expect(v.length).to be_within(0.001).of Math.sqrt(3.0)
        end
      end
    end

    describe '#length_squared' do
      context 'called on a unit vector' do
        let(:v) { [Vector3.i, Vector3.j, Vector3.k].sample }

        it 'returns 1.0' do
          expect(v.length_squared).to be_within(0.001).of 1.0
        end
      end

      context 'called on a vector' do
        let(:v) { Vector3.new(1.0, 1.0, 1.0) }

        it 'returns the length squared' do
          expect(v.length_squared).to be_within(0.001).of 3.0
        end
      end
    end

    describe '#normalize' do
      let(:v) { Vector3.new(2.0, 2.0, 2.0) }
      let(:vn) { v.normalize }

      it 'returns a new unit vector' do
        expect(vn).to be_a Vector3
        expect(vn).to_not be v
        expect(vn.length).to be_within(0.001).of 1.0
      end

      it 'returns a vector pointing in the same direction' do
        expect(vn.x).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
        expect(vn.y).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
        expect(vn.z).to be_within(0.001).of(1.0 / Math.sqrt(3.0))
      end
    end

    describe '#to_v' do
      let(:u) { Vector3.new(1.0, 2.0, 3.0) }
      let(:v) { u.to_v }

      it 'returns a new Vector3 pointing in the same direction' do
        expect(v).to be_a Vector3
        expect(v).to eq u
        expect(v).to_not be u
      end
    end

    describe '#to_p' do
      let(:v) { Vector3.new(1.0, 2.0, 3.0) }
      let(:p) { v.to_p }

      it 'returns a Point3 with the same components' do
        expect(p).to be_a Point3
        expect(p.x).to eq v.x
        expect(p.y).to eq v.y
        expect(p.z).to eq v.z
      end
    end
  end
end
