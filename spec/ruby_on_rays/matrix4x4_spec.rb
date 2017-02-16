require 'spec_helper'

module RubyOnRays
  describe Matrix4x4 do
    describe '.new' do
      context 'given no arguments' do
        let(:m) { Matrix4x4.new }

        it 'returns an empty matrix' do
          (0...4).each do |row|
            (0...4).each do |col|
              expect(m[row, col]).to eq 0.0
            end
          end
        end
      end

      context 'given an Array of fewer than 16 elements' do
        let(:too_few) { Array.new(15) }

        it 'raises an ArgumentError' do
          expect { Matrix4x4.new(too_few) }.to raise_error ArgumentError
        end
      end

      context 'given an Array of 16 elements' do
        let(:m) { Matrix4x4.new(Array(1..16)) }

        it 'returns a matrix with the elements in row-first order' do
          (0...4).each do |i|
            (0...4).each do |j|
              expect(m[i, j]).to eq(i * 4 + j + 1)
            end
          end
        end
      end

      context 'given an Array of more than 16 elements' do
        let(:too_many) { Array.new(17) }

        it 'raises an ArgumentError' do
          expect { Matrix4x4.new(too_many) }.to raise_error ArgumentError
        end
      end
    end

    describe '#mul' do
      context 'given a scalar' do
        let(:matrix) do
          Matrix4x4.new([0.0,  1.0,  2.0,  3.0,
                         4.0,  5.0,  6.0,  7.0,
                         8.0,  9.0, 10.0, 11.0,
                         12.0, 13.0, 14.0, 15.0])
        end
        let(:scalar) { 2.0 }
        let(:product) { matrix.mul(scalar) }

        it 'multiplies each element by the scalar' do
          product.each_with_indices do |v, row, col|
            x = col + 4 * row
            expect(v).to be_within(0.001).of(2.0 * x)
          end
        end
      end
    end

    describe '#transpose' do
      let(:m) do
        Matrix4x4.new([1.0,  2.0,  3.0,  4.0,
                       5.0,  6.0,  7.0,  8.0,
                       9.0,  10.0, 11.0, 12.0,
                       13.0, 14.0, 15.0, 16.0])
      end
      let(:t) { m.transpose }

      it 'returns a new Matrix4x4' do
        expect(t).to be_a Matrix4x4
        expect(t).to_not be m
      end

      it 'returns the transpose' do
        expect(t).to eq Matrix4x4.new([1.0, 5.0, 9.0,  13.0,
                                       2.0, 6.0, 10.0, 14.0,
                                       3.0, 7.0, 11.0, 15.0,
                                       4.0, 8.0, 12.0, 16.0])
      end
    end

    describe '#determinant' do
      let(:m) do
        Matrix4x4.new([0.0, 4.0, 0.0, -3.0,
                       1.0, 1.0, 5.0, 2.0,
                       1.0, -2.0, 0.0, 6.0,
                       3.0, 0.0, 0.0, 1.0])
      end

      it 'returns the determinant' do
        expect(m.determinant).to be_within(0.001).of(-250.0)
      end
    end

    describe '#inverse' do
      context 'given the identity matrix'
      context 'given a singular matrix'

      context 'given an non-identity invertible matrix' do
        let(:m) do
          Matrix4x4.new([0.0, 4.0, 0.0, -3.0,
                         1.0, 1.0, 5.0, 2.0,
                         1.0, -2.0, 0.0, 6.0,
                         3.0, 0.0, 0.0, 1.0])
        end
        let(:mi) { m.inverse }
        let(:expected) do
          Matrix4x4.new([-0.04, 0.0, -0.08, 0.36,
                         0.34, 0.0, 0.18, -0.06,
                         -0.12, 0.2, -0.12, -0.03,
                         0.12, 0.0, 0.24, -0.08])
        end

        it 'returns a new Matrix4x4' do
          expect(mi).to be_a Matrix4x4
          expect(mi).to_not eq m
        end

        it 'returns the matrix inverse' do
          mi.each_with_indices do |v, row, col|
            expect(v).to be_within(0.1).of expected[row, col]
          end
        end
      end
    end
  end
end
