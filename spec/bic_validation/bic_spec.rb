require 'spec_helper'

module BicValidation
  describe Bic do

    context 'basic methods 11 digit' do
      before { @bic = Bic.new 'MARKDEF1850' }

      subject { @bic }

      describe '#valid?' do
        it { should be_valid }
      end

      describe '#known?' do
        it { should be_known }
      end

      describe '#bank' do
        its(:bank) { should eq('MARK') }
      end

      describe '#country' do
        its(:country) { should eq('DE') }
      end

      describe '#location' do
        its(:location) { should eq('F1') }
      end

      describe '#branch' do
        its(:branch) { should eq('850') }
      end
    end

    context 'basic methods 8 digit' do
      before { @bic = Bic.new 'DEUTDEBB' }

      subject { @bic }

      describe '#valid?' do
        it { should be_valid }
      end

      describe '#known?' do
        it { should be_known }
      end

      describe '#bank' do
        its(:bank) { should eq('DEUT') }
      end

      describe '#country' do
        its(:country) { should eq('DE') }
      end

      describe '#location' do
        its(:location) { should eq('BB') }
      end

      describe '#branch' do
        its(:branch) { should be_nil }
      end
    end

    ['DEUTDEBB', 'CRESCHZZ10S', 'UBSWCHZH86N', 'OEKOATWWXXX',
     'OEKOATWW'].each do |swift|
      describe 'validity checks' do
        it "validates #{swift}" do
          bic = Bic.new(swift)
          expect(bic).to be_valid
          expect(bic).to be_known
        end
      end
    end
  end
end
