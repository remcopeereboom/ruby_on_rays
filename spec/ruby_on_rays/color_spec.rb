require 'spec_helper'

module RubyOnRays
  describe Color do
    describe '.new' do
      context 'given a red, a green, and a blue spectrum coefficient' do
        let(:red) { rand(0.0..1000.0) }
        let(:green) { rand(0.0..1000.0) }
        let(:blue) { rand(0.0..1000.0) }
        let(:color) { Color.new(red, green, blue) }

        it 'returns a color with the given coefficients' do
          expect(color).to be_a Color
          expect(color.r).to eq red
          expect(color.g).to eq green
          expect(color.b).to eq blue
        end
      end
    end

    describe '#-@' do
      let(:rhs) { Color.new(1.0, 2.0, 3.0) }
      let(:neg) { -rhs }

      it 'returns a new Color' do
        expect(neg).to be_a Color
        expect(neg).to_not be rhs
      end

      it 'negates the color components' do
        expect(neg.r).to be_within(0.001).of(-1.0)
        expect(neg.g).to be_within(0.001).of(-2.0)
        expect(neg.b).to be_within(0.001).of(-3.0)
      end
    end

    describe '#add' do
      context 'given another color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:sum) { lhs.add(rhs) }

        it 'returns a new color' do
          expect(sum).to be_a Color
          expect(sum).to_not eq lhs
          expect(sum).to_not eq rhs
        end

        it 'sums the components' do
          expect(sum.r).to be_within(0.001).of 5.0
          expect(sum.g).to be_within(0.001).of 7.0
          expect(sum.b).to be_within(0.001).of 9.0
        end
      end
    end

    describe '#add!' do
      context 'given another color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:sum) { lhs.add!(rhs) }

        it 'returns self' do
          expect(sum).to be lhs
          expect(sum).to_not be rhs
        end

        it 'sums the components' do
          expect(sum.r).to be_within(0.001).of 5.0
          expect(sum.g).to be_within(0.001).of 7.0
          expect(sum.b).to be_within(0.001).of 9.0
        end
      end
    end

    describe '#sub' do
      context 'given another color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:difference) { lhs.sub(rhs) }

        it 'returns a new color' do
          expect(difference).to be_a Color
          expect(difference).to_not eq lhs
          expect(difference).to_not eq rhs
        end

        it 'subtracts the components' do
          expect(difference.r).to be_within(0.001).of(-3.0)
          expect(difference.g).to be_within(0.001).of(-3.0)
          expect(difference.b).to be_within(0.001).of(-3.0)
        end
      end
    end

    describe '#sub!' do
      context 'given another color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:difference) { lhs.sub!(rhs) }

        it 'returns self' do
          expect(difference).to be lhs
          expect(difference).to_not be rhs
        end

        it 'subtracts the components' do
          expect(difference.r).to be_within(0.001).of(-3.0)
          expect(difference.g).to be_within(0.001).of(-3.0)
          expect(difference.b).to be_within(0.001).of(-3.0)
        end
      end
    end

    describe '#mul' do
      context 'given a number' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul(rhs) }

        it 'returns a new color' do
          expect(product).to be_a Color
          expect(product).to_not eq lhs
        end

        it 'multiplies the components by the scalar' do
          expect(product.r).to be_within(0.001).of 2.0
          expect(product.g).to be_within(0.001).of 4.0
          expect(product.b).to be_within(0.001).of 6.0
        end
      end

      context 'given a color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:product) { lhs.mul(rhs) }

        it 'returns a new color' do
          expect(product).to be_a Color
          expect(product).to_not eq lhs
          expect(product).to_not eq rhs
        end

        it 'multiplies the components' do
          expect(product.r).to be_within(0.001).of 4.0
          expect(product.g).to be_within(0.001).of 10.0
          expect(product.b).to be_within(0.001).of 18.0
        end
      end

      context 'given something else' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { :foo }

        it 'raises an ArgumentError' do
          expect { lhs.mul(rhs) }.to raise_error ArgumentError
        end
      end
    end

    describe '#mul!' do
      context 'given a number' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:product) { lhs.mul!(rhs) }

        it 'returns self' do
          expect(product).to be lhs
        end

        it 'multiplies the components by the scalar' do
          expect(product.r).to be_within(0.001).of 2.0
          expect(product.g).to be_within(0.001).of 4.0
          expect(product.b).to be_within(0.001).of 6.0
        end
      end

      context 'given a color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 5.0, 6.0) }
        let(:product) { lhs.mul!(rhs) }

        it 'returns self' do
          expect(product).to be lhs
          expect(product).to_not be rhs
        end

        it 'multiplies the components' do
          expect(product.r).to be_within(0.001).of 4.0
          expect(product.g).to be_within(0.001).of 10.0
          expect(product.b).to be_within(0.001).of 18.0
        end
      end

      context 'given something else' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { :foo }

        it 'raises an ArgumentError' do
          expect { lhs.mul!(rhs) }.to raise_error ArgumentError
        end
      end
    end

    describe '#div' do
      context 'given a number' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quoutient) { lhs.div(rhs) }

        it 'returns a new color' do
          expect(quoutient).to be_a Color
          expect(quoutient).to_not eq lhs
        end

        it 'divides the components by the scalar' do
          expect(quoutient.r).to be_within(0.001).of 0.5
          expect(quoutient.g).to be_within(0.001).of 1.0
          expect(quoutient.b).to be_within(0.001).of 1.5
        end
      end

      context 'given a color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 8.0, 12.0) }
        let(:quoutient) { lhs.div(rhs) }

        it 'returns a new color' do
          expect(quoutient).to be_a Color
          expect(quoutient).to_not eq lhs
          expect(quoutient).to_not eq rhs
        end

        it 'divides the components' do
          expect(quoutient.r).to be_within(0.001).of 0.25
          expect(quoutient.g).to be_within(0.001).of 0.25
          expect(quoutient.b).to be_within(0.001).of 0.25
        end
      end

      context 'given something else' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { :foo }

        it 'raises an ArgumentError' do
          expect { lhs.div(rhs) }.to raise_error ArgumentError
        end
      end
    end

    describe '#div!' do
      context 'given a number' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { 2.0 }
        let(:quotient) { lhs.div!(rhs) }

        it 'returns self' do
          expect(quotient).to be lhs
        end

        it 'multiplies the components by the scalar' do
          expect(quotient.r).to be_within(0.001).of 0.5
          expect(quotient.g).to be_within(0.001).of 1.0
          expect(quotient.b).to be_within(0.001).of 1.5
        end
      end

      context 'given a color' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { Color.new(4.0, 8.0, 12.0) }
        let(:quotient) { lhs.div!(rhs) }

        it 'returns self' do
          expect(quotient).to be lhs
          expect(quotient).to_not be rhs
        end

        it 'divides the components' do
          expect(quotient.r).to be_within(0.001).of 0.25
          expect(quotient.g).to be_within(0.001).of 0.25
          expect(quotient.b).to be_within(0.001).of 0.25
        end
      end

      context 'given something else' do
        let(:lhs) { Color.new(1.0, 2.0, 3.0) }
        let(:rhs) { :foo }

        it 'raises an ArgumentError' do
          expect { lhs.div!(rhs) }.to raise_error ArgumentError
        end
      end
    end

    describe '#black?' do
      context 'called on a black color' do
        let(:color) { Color.new(0.0, 0.0, 0.0) }

        it 'returns true' do
          expect(color.black?).to be true
        end
      end

      context 'called on a non-black color' do
        let(:rgb) { [0.0, 0.0, 0.1].shuffle }
        let(:color) { Color.new(*rgb) }

        it 'returns false' do
          expect(color.black?).to be false
        end
      end
    end
  end
end
