module BicValidation
  class BicValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      bic = Bic.new(value)
      if bic.valid?
        unless bic.known?
          record.errors.add attribute, 'is a not a known BIC'
        end
      else
        record.errors.add attribute, 'is a not a well-formated BIC'
      end
    end
  end
end
