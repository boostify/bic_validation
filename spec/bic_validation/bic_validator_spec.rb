require 'spec_helper'

module BicValidation
  describe BicValidator do
    class Model
      include ActiveModel::Validations
      attr_accessor :bic
      validates :bic, bic: true

      def initialize(bic)
        @bic = bic
      end
    end

    it 'is valid' do
      model = Model.new 'DEUTDEFF'
      model.valid?
      expect(model.errors.count).to eq(0)
    end

    it 'is unknown' do
      model = Model.new 'DXUTDEFF'
      model.valid?
      expect(model.errors.count).to eq(1)
    end

    it 'is invalid' do
      model = Model.new 'DXUTDE'
      model.valid?
      expect(model.errors.count).to eq(1)
    end
  end
end
