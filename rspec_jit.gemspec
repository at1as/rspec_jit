# frozen_string_literal: true

#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'rspec_jit'
  s.version     = "1.0.0"
  s.date        = '2018-12-10'
  s.summary     = %q{Run RSpec tests with JIT}
  s.description = %q{Run RSpec test suites with Ruby's JIT flag enabled}
  s.authors     = ["Jason Willems"]
  s.email       = 'hello@jasonwillems.com'
  s.homepage    = 'https://github.com/at1as/rspec_jit'
  s.license     = 'MIT'
  s.files       = ["bin/rspec_jit"]
  s.executables = ["rspec_jit"]

  # This requires a *nix operating system
  s.platform    = "ruby"

  s.add_runtime_dependency "rspec", '~> 3'
  s.add_runtime_dependency "rspec-core", '~> 3'
end
