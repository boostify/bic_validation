module BicValidation
  class BicValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, values)
      unless Bic.valid? values
        record.errors.add attribute, 'is not a valid IBAN'
      end
    end
  end
end
