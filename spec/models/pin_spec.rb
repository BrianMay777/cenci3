require 'spec_helper'

describe Pin do
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
        @pin = Fabricate(:pin, :pin => @good_pin)
      end
      it "should find a Pin if it exists" do
        Pin.find_by_pin(@good_pin).should == @pin
      end
      it "should return an invalid pin otherwise" do
        Pin.find_by_pin(@bad_pin).should_not be_valid
      end
    end
  end
end
