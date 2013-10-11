require 'spec_helper'

module BicValidation
  describe Bic do

    describe '#valid?' do
      bic = Bic.new 'MARKDEFF'
      bic.valid?.should == true
    end

  end
end
