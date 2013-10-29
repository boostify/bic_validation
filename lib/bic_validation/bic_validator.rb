module BicValidation
  class BicValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      bic = Bic.new(value)
      if bic.valid?
        unless bic.known?
          record.errors.add attribute, :known_bic
        end
      else
        record.errors.add attribute, :format
      end
    end
  end
end
