require 'spec_helper'

module RubyOnRays
  describe Transform do
    describe '.identity' do
      let(:identity) { Transform.identity }

      it 'returns a Transform' do
        expect(identity).to be_a Transform
      end

      context 'applied to a vector' do
        let(:v) { Vector3.new(1.0, 2.0, 3.0) }
        let(:tv) { identity.transform(v) }

        it 'leaves vectors unchanged' do
          expect(tv).to eq v
        end
      end

      context 'applied to a point' do
        let(:p) { Point3.new(1.0, 2.0, 3.0) }
        let(:tp) { identity.transform(p) }

        it 'leaves points unchanged' do
          expect(tp).to eq p
        end
      end
    end

    describe '.translate' do
      context 'given offsets dx, dy, and dz' do
        let(:dx) { 1.0 }
        let(:dy) { 2.0 }
        let(:dz) { 3.0 }
        let(:translate) { Transform.translate(dx, dy, dz) }

        context 'applied to a vector' do
          let(:v) { Vector3.new(1.0, 2.0, 3.0) }
          let(:tv) { translate.transform(v) }

          it 'leaves the vector unchanged' do
            expect(tv).to eq v
          end
        end

        context 'applied to a point' do
          let(:p) { Point3.new(1.0, 2.0, 3.0) }
          let(:tp) { translate.transform(p) }

          it 'translates the point in the x direction by dx' do
            expect(tp.x).to eq p.x + dx
          end

          it 'translates the point in the y direction by dy' do
            expect(tp.y).to eq p.y + dy
          end

          it 'translates the point in the z direction by dz' do
            expect(tp.z).to eq p.z + dz
          end
        end
      end
    end

    describe '.scale' do
      context 'given scaling factors sx, sy, and sz' do
        let(:sx) { 4.0 }
        let(:sy) { 5.0 }
        let(:sz) { 6.0 }
        let(:scale) { Transform.scale(sx, sy, sz) }

        it 'scales' do
          expect(scale.scales?).to be true
        end

        context 'applied to a vector' do
          let(:v) { Vector3.new(1.0, 2.0, 3.0) }
          let(:tv) { scale.transform(v) }

          it 'scales the vector in the x direction by dx' do
            expect(tv.x).to be_within(0.001).of(sx * v.x)
          end

          it 'scales the vector in the y direction by dy' do
            expect(tv.y).to be_within(0.001).of(sy * v.y)
          end

          it 'scales the vector in the z direction by dz' do
            expect(tv.z).to be_within(0.001).of(sz * v.z)
          end
        end

        context 'applied to a point' do
          let(:p) { Point3.new(1.0, 2.0, 4.0) }
          let(:tp) { scale.transform(p) }

          it 'scales the point in the x direction by dx' do
            expect(tp.x).to be_within(0.001).of(sx * p.x)
          end

          it 'scales the point in the y direction by dy' do
            expect(tp.y).to be_within(0.001).of(sy * p.y)
          end

          it 'scales the point in the z direction by dz' do
            expect(tp.z).to be_within(0.001).of(sz * p.z)
          end
        end
      end
    end

    describe '.rotate_x' do
      context 'given an angle in radians' do
        let(:angle) { Math::PI }
        let(:rotate) { Transform.rotate_x(angle) }

        context 'applied to Vector3.i' do
          let(:v) { Vector3.i }
          let(:tv) { rotate.transform(v) }

          it 'leaves the vector unchanged' do
            expect(tv).to eq v
          end
        end

        context 'applied to a vector' do
          let(:v) { Vector3.new(1.0, 2.0, 3.0) }
          let(:tv) { rotate.transform(v) }

          it 'rotates the vector around the x-axis' do
            expect(tv.x).to be_within(0.001).of(v.x)
            expect(tv.y).to be_within(0.001).of(-v.y)
            expect(tv.z).to be_within(0.001).of(-v.z)
          end
        end

        context 'applied to the origin' do
          let(:p) { Point3.origin }
          let(:tp) { rotate.transform(p) }

          it 'leaves the point unchanged' do
            expect(tp).to eq p
          end
        end

        context 'applied to a point' do
          let(:p) { Point3.new(1.0, 2.0, 3.0) }
          let(:tp) { rotate.transform(p) }

          it 'rotates the point around the x-axis' do
            expect(tp.x).to be_within(0.001).of(p.x)
            expect(tp.y).to be_within(0.001).of(-p.y)
            expect(tp.z).to be_within(0.001).of(-p.z)
          end
        end
      end
    end

    describe '.rotate_y' do
      context 'given an angle in radians' do
        let(:angle) { Math::PI }
        let(:rotate) { Transform.rotate_y(angle) }

        context 'applied to Vector3.j' do
          let(:v) { Vector3.j }
          let(:tv) { rotate.transform(v) }

          it 'leaves the vector unchanged' do
            expect(tv).to eq v
          end
        end

        context 'applied to a vector' do
          let(:v) { Vector3.new(1.0, 2.0, 3.0) }
          let(:tv) { rotate.transform(v) }

          it 'rotates the vector around the y-axis' do
            expect(tv.x).to be_within(0.001).of(-v.x)
            expect(tv.y).to be_within(0.001).of(v.y)
            expect(tv.z).to be_within(0.001).of(-v.z)
          end
        end

        context 'applied to the origin' do
          let(:p) { Point3.origin }
          let(:tp) { rotate.transform(p) }

          it 'leaves the point unchanged' do
            expect(tp).to eq p
          end
        end

        context 'applied to a point' do
          let(:p) { Point3.new(1.0, 2.0, 3.0) }
          let(:tp) { rotate.transform(p) }

          it 'rotates the point around the y-axis' do
            expect(tp.x).to be_within(0.001).of(-p.x)
            expect(tp.y).to be_within(0.001).of(p.y)
            expect(tp.z).to be_within(0.001).of(-p.z)
          end
        end
      end
    end

    describe '.rotate_z' do
      context 'given an angle in radians' do
        let(:angle) { Math::PI }
        let(:rotate) { Transform.rotate_z(angle) }

        context 'applied to Vector3.k' do
          let(:v) { Vector3.k }
          let(:tv) { rotate.transform(v) }

          it 'leaves the vector unchanged' do
            expect(tv).to eq v
          end
        end

        context 'applied to a vector' do
          let(:v) { Vector3.new(1.0, 2.0, 3.0) }
          let(:tv) { rotate.transform(v) }

          it 'rotates the vector around the z-axis' do
            expect(tv.x).to be_within(0.001).of(-v.x)
            expect(tv.y).to be_within(0.001).of(-v.y)
            expect(tv.z).to be_within(0.001).of(v.z)
          end
        end

        context 'applied to the origin' do
          let(:p) { Point3.origin }
          let(:tp) { rotate.transform(p) }

          it 'leaves the point unchanged' do
            expect(tp).to eq p
          end
        end

        context 'applied to a point' do
          let(:p) { Point3.new(1.0, 2.0, 3.0) }
          let(:tp) { rotate.transform(p) }

          it 'rotates the point around the z-axis' do
            expect(tp.x).to be_within(0.001).of(-p.x)
            expect(tp.y).to be_within(0.001).of(-p.y)
            expect(tp.z).to be_within(0.001).of(p.z)
          end
        end
      end
    end

    describe '.invert' do
      let(:t) { Transform.translate(1.0, 2.0, 3.0) }
      let(:ti) { Transform.invert(t) }

      it 'returns a new transform' do
        expect(ti).to be_a Transform
        expect(ti).to_not be t
      end

      it 'is the inverse of the original transform' do
        expect(ti.m).to eq t.mi
        expect(ti.mi).to eq t.m
      end
    end
  end
end
