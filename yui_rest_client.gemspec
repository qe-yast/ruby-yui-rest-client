# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yui_rest_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'yui_rest_client'
  spec.version       = YuiRestClient::VERSION
  spec.required_ruby_version = '>= 2.5.0'
  spec.authors       = ['Joaquin Rivera', 'Ioannis Bonatakis', 'Oleksandr Orlov', 'Rodion Iafarov', 'Sofia Syrianidou']
  spec.email         = ['qa-sle-yast@suse.de']

  spec.summary       = 'Client for libyui applications.'
  spec.description   = 'Client to operate controls for libyui applications.'
  # spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = 'MIT'
  spec.metadata      = { 'source_code_uri' => 'https://github.com/qe-yast/libyui_test_framework' }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'date'
  spec.add_development_dependency 'json'
  spec.add_development_dependency 'net'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'time'
  spec.add_development_dependency 'timeout'
  spec.add_development_dependency 'uri'
end
