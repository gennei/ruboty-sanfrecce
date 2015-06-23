# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruboty/sanfrecce/version'

Gem::Specification.new do |spec|
  spec.name          = "ruboty-sanfrecce"
  spec.version       = Ruboty::Sanfrecce::VERSION
  spec.authors       = ["gennei"]
  spec.email         = ["sai.gennei@gmail.com"]
  spec.summary       = %q{Ruboty-Sanfrecce}
  spec.description   = %q{Sanfrecce Game Schedule}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruboty"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "false"
end
