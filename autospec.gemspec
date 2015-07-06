# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autospec/version'

Gem::Specification.new do |spec|
  spec.name          = "autospec"
  spec.version       = Autospec::VERSION
  spec.authors       = ["Peijie Hu"]
  spec.email         = ["tradev.pj@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Helper to build test automation framework with rspec and capybara}
  spec.description   = %q{Helper to build test automation framework with rspec and capybara}
  spec.homepage      = "https://github.com/peijiehu/autospec"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'capybara', '~> 2.4.4'
  spec.add_dependency 'selenium-webdriver', '~> 2.46'
  spec.add_dependency 'activesupport', '~> 4.0.0'
  spec.add_dependency 'rest-client', '~> 1.7.3'
  spec.add_dependency 'capybara-webkit', '~> 1.5.2'

  spec.add_development_dependency 'bundler', '~> 1.8'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end