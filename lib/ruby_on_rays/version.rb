module RubyOnRays
  # Version
  #
  # Semantic version information for the Ruby goes Rays program.
  module Version
    MAJOR = 0 # Major version. Updates on breaking changes.
    MINOR = 1 # Minor version. Updates on non-breaking feature additions.
    PATCH = 0 # Patch version. Updates on non-breaking fixes.

    # Returns the full version as a string.
    # @return [String]
    def self.full
      "#{MAJOR}.#{MINOR}.#{PATCH}"
    end
  end
end
