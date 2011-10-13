require 'spec_helper'

describe ProviderPin do
  describe "schema" do
    it { should have_field(:pin).of_type(Integer) }
    it { should have_field(:provider).of_type(String) }

    describe "validations" do
      it { should validate_presence_of(:pin) }
      it { should validate_numericality_of(:pin) }
      it { should validate_uniqueness_of(:pin) }
    end
  end

  describe "scopes" do
    describe "find_by_pin" do
      before(:each) do
        @good_pin = 1111111111
        @bad_pin  = 2222222222
        @pin = Fabricate(:provider_pin, :pin => @good_pin)
      end
      it "should find a ProviderPin if it exists" do
        ProviderPin.find_by_pin(@good_pin).should == @pin
        ProviderPin.find_by_pin(@good_pin).should be_valid
      end
      it "should return an nil" do
        ProviderPin.find_by_pin(@bad_pin).should be_nil
      end
    end
  end
end
