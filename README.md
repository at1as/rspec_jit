# Runs RSpec with MJIT enabled

Ruby 2.6 added an experimental Just In Time compiler. It is disabled by default, but can be enabled by providing the `--jit` flag to the Ruby executable.

### Installation

rpsec_jit is published as a [gem](https://rubygems.org/gems/rspec_jit)

```
gem install rspec_jit
```

### Motivation

A JIT makes certain things faster, however not everything will benefit, and not everything is fully supported (Rails still slows down significantly with the JIT, and ActiveRecord and Nokogiri are not fully supported).

The JIT introduces extra latency during it's "warm up" period. Java is famous for very long start up times. The JIT will also increase memory usage.

It can be tough to tell if the current implementation of the JIT will speed up a given program. I've had mixed results so far. That's why we benchmark (and why we need an easy way to enable or disable the JIT)!


### Running RSpec with JIT

Patching RSpec to pass the `jit` flag is unfortunately not a tenable solution. The `--jit` flag must prceede the rspec executable, and this is not possible after the ruby process has started. Patching RSpec to pass the `--jit` flag as below does not not actually enable the JIT. The order of `...rspec` and `--jit` would need to be reversed.

```
# JIT will not actually be enabled

ruby /usr/local/bin/rspec --jit mjit_enabled_spec.rb
```

Although its use is discouraged, instead of using the rspec binary `rspec ...`, RSpec can be invoked the following way, and this will allow us to enable the JIT:

```
$ ruby --jit -Ilib -Ispec -rrspec/autorun spec/test_file_spec.rb
```

This allows us to force enable/disable the JIT by providing or omitting the flag from Ruby

This is rather clunky, and an easier way would be desirable.

### Verifying the JIT is actually enabled

This program will run rspec with the JIT enabled if the ruby version is at least 2.6.X (the version in which the JIT was added). If an older version of Ruby is used, it will simply run rspec and omit the flag. 

Simple test case to verify if the JIT is enabled

```
require 'rspec'

RSpec.describe RubyVM::MJIT do
  it "mjit should be enabled" do
    expect(defined?(RubyVM::MJIT) && RubyVM::MJIT.enabled?).to eq(true)
  end
end

```

### Gotchas

At this stage, This is purely an experimental endeavor. RSpec is not currently designed to make use of the JIT.

Its codebase will likely require updates to call `RubyVM::MJIT.pause` and `RubyVM::MJIT.resume` at certain places to ensure each test is providing an accurate benchmark. This script may only be useful for long running tests, or may not be useful at all. It will require some deeper understand of how the JIT is implemented and profiling of its effects to have a clearer idea.


### Environment

Tested with:
* MacOS 10.12 
* bash & zsh shells 
* Ruby versions 2.3, 2.4, 2.5, 2.6.0-rc1

