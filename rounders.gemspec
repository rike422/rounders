# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rounders/version'

Gem::Specification.new do |spec|
  spec.name          = 'rounders'
  spec.version       = Rounders::VERSION
  spec.authors       = ['akira.takahashi']
  spec.email         = ['rike422@gmail.com']

  spec.summary       = 'bot-ish pluggable incoming mail processing framework'
  spec.homepage      = 'https://github.com/rike422/rounders'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2.0'
  spec.add_development_dependency 'pry'
  spec.add_dependency 'dotenv'
  spec.add_dependency 'dry-configurable'
  spec.add_dependency 'mail', '~> 2.6.4'
  spec.add_dependency 'mail-gpg'
  spec.add_dependency 'hanami-utils'
  spec.add_dependency 'thor'
end
