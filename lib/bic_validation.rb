require 'active_model'
require 'smarter_csv'
require 'banking_data'
require 'bic_validation/bic'
require 'bic_validation/bic_validator'
require 'bic_validation/version'

module BicValidation
end

ActiveModel::Validations.send(:include, BicValidation)
