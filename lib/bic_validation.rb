require 'active_model'
require 'banking_data'
require 'bic_validation/bic'
require 'bic_validation/bic_validator'
require 'bic_validation/version'

module BicValidation
end

ActiveModel::Validations.send(:include, BicValidation)
I18n.load_path += Dir[File.expand_path(File.join(File.dirname(__FILE__),
  '../locales', '*.yml')).to_s]
