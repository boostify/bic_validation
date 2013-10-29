# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bic_validation/version'

Gem::Specification.new do |gem|
  gem.name          = "bic_validation"
  gem.version       = BicValidation::VERSION
  gem.authors       = ["Frank C. Eckert"]
  gem.email         = ["frank.eckert@boost-project.com"]
  gem.description   = <<-EOF
    BicValidation provides a simple ActiveModel::EachValidator for
    formally validating Business Identifier Codes (BIC) aka SWIFT-codes.
  EOF
  gem.summary       = %q{ActiveModel BIC validator}
  gem.homepage      = "https://github.com/opahk/bic_validation"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activemodel'
  gem.add_dependency 'activesupport'
  gem.add_dependency 'banking_data'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'coveralls'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rubocop'

  if ENV['RUBY_VERSION'] =~ /rbx/
    gem.add_dependency 'rubysl'
    gem.add_development_dependency 'rubinius-coverage'
  end
end
