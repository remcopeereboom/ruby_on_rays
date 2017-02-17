require 'spec_helper'

module RubyOnRays
  describe Version do
    describe '::MAJOR' do
      it 'is an integer' do
        expect(Version::MAJOR).to be_an Integer
      end

      it 'is non-negative' do
        expect(Version::MAJOR).to_not be_negative
      end
    end

    describe '::MINOR' do
      it 'is an integer' do
        expect(Version::MINOR).to be_an Integer
      end

      it 'is non-negative' do
        expect(Version::MINOR).to_not be_negative
      end
    end

    describe '::PATCH' do
      it 'is an integer' do
        expect(Version::PATCH).to be_an Integer
      end

      it 'is non-negative' do
        expect(Version::PATCH).to_not be_negative
      end
    end

    describe '.full' do
      it 'returns a string' do
        expect(Version.full).to be_a String
      end

      it 'matches the semver.org specification' do
        basic      = '\d+.\d+\.\d+'
        prerelease = '-[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)?'
        metadata   = '\+[0-9A-Za-z-]+(\.[0-9A-Za-z-]+)?'

        full = /\A#{basic}(#{prerelease})?(#{metadata})?\z/

        expect(Version.full).to match full
      end
    end
  end
end
