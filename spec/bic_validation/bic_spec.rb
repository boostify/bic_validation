require 'spec_helper'

module BicValidation
  describe Bic do

    before { @bic = Bic.new 'MARKDEFF' }

    subject { @bic }

    describe '#valid?' do
      it { should be_valid }
    end

    describe '#bank' do
      its(:bank) { should eq('MARK') }
    end

    describe '#country' do
      its(:country) { should eq('DE') }
    end

    describe '#location' do
      its(:location) { should eq('FF') }
    end

    describe '#branch' do
      its(:branch) { should be_nil }
    end
  end
end
