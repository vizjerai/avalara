# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'avalara/version'

Gem::Specification.new do |spec|
  spec.name        = 'vizjerai-avalara'
  spec.version     = Avalara::VERSION
  spec.authors     = ['Adam Fortuna', 'Andrew Assarattanakul']
  spec.email       = ['adam@envylabs.com', 'assarata@gmail.com']
  spec.description = %q{This library provides Ruby calls to interact with the Avalara Tax API}
  spec.summary     = %q{A Ruby interface to the Avalara Tax API}
  spec.homepage    = 'https://github.com/vizjerai/avalara'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'hashie',     '~> 2.0'
  spec.add_dependency 'httparty',   '~> 0.11'
  spec.add_dependency 'multi_json', '~> 1.7'

  spec.add_development_dependency 'vcr', '>= 2.0.0'
  spec.add_development_dependency 'webmock', '>= 1.9.1'
  spec.add_development_dependency 'rspec', '>= 2.0.0'
  spec.add_development_dependency 'factory_girl', '>= 4.0.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
