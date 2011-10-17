require 'spec_helper'

describe Account do

  describe "schema" do
    it { should be_timestamped_document }
    it { should have_field(:address).of_type(String) }
    it { should have_field(:phone).of_type(String) }
    it { should have_field(:id_type).of_type(String) }
    it { should have_field(:id_number).of_type(String) }
    it { should have_field(:agree_to_terms).of_type(DateTime) }
    it { should have_field(:approved_at).of_type(DateTime) }
    it { should have_field(:state).of_type(Symbol) }
    it { should have_one(:provider_pin) }
    it { should have_many(:registered_pins) }
    it { should belong_to(:parent) }
    it { should have_many(:children) }

    describe "validations" do
      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:phone) }
      it { should validate_presence_of(:id_type) }
      it { should validate_presence_of(:id_number) }
      it { should validate_presence_of(:agree_to_terms) }
      it { should validate_presence_of(:state) }
    end
  end

  describe "scopes" do
  end

  describe "workflow" do

    let(:agent) { Fabricate(:agent) }
    let(:provider_pin) { Fabricate(:provider_pin) }
    subject { Fabricate(:account, :provider_pin => provider_pin) }

    it "should have a default state of :pending" do
      subject.should be_pending
    end

    it "should transition to :approved on approve!" do
      subject.approve!(agent).should be_true
      subject.should be_approved
    end

    it "should set approved_by on approve!" do
      subject.approve!(agent).should be_true
      subject.approved_by.should equal(agent)
    end

    it "should set approved_at on approve!" do
      subject.approve!(agent).should be_true
      subject.approved_at.should be_a(DateTime)
    end

  end
end
