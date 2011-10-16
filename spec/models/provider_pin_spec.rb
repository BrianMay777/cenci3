require 'spec_helper'

describe ProviderPin do

  describe "schema" do
    it { should have_field(:pin).of_type(Integer) }
    it { should have_field(:provider).of_type(String) }
    it { should have_field(:state).of_type(Symbol) }
    it { should be_timestamped_document }

    describe "validations" do
      it { should validate_presence_of(:pin) }
      it { should validate_numericality_of(:pin) }
      it { should validate_uniqueness_of(:pin) }
      it { should validate_presence_of(:provider) }
      it { should validate_inclusion_of(:provider).to_allow(AppConfig.providers) }
      it { should validate_presence_of(:state) }
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

  describe "workflow" do

    subject { Fabricate(:provider_pin) }
    let(:account) { Fabricate(:account, :provider_pin => subject) }

    it "should have a default state of :loaded" do
      subject.should be_loaded
    end

    it "should transition to :assigned on assign!" do
      subject.assign!(account)
      subject.should be_assigned
    end

    it "should set account on assign!" do
      subject.assign!(account)
      subject.account.should equal(account)
    end

  end

end
