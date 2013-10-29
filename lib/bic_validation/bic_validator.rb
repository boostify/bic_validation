module BicValidation
  class BicValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      bic = Bic.new(value)
      if bic.valid?
        unless bic.known?
          record.errors.add attribute, :unknown
        end
      else
        record.errors.add attribute, :invalid
      end
    end
  end
end
