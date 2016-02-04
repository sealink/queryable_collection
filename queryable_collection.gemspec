# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'queryable_collection/version'

Gem::Specification.new do |spec|
  spec.name          = 'queryable_collection'
  spec.version       = QueryableCollection::VERSION
  spec.authors       = ['Akil Madan']
  spec.email         = ['support@travellink.com.au']

  spec.summary       = 'Allows the creation and querying of a collection of elements'
  spec.description   = 'Allows the caller to define a queryable collection of ' \
                       'elements and the attributes that can be used for querying. ' \
                       'Provides the necessary methods to query the collection'
  spec.homepage      = 'https://github.com/sealink/queryable_collection'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'

  spec.add_dependency 'adamantium', '~> 0.2'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'travis'
end
