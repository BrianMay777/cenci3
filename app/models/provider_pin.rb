class ProviderPin
  include Mongoid::Document
  include Mongoid::Timestamps
  include Workflow

  field :pin, :type => Integer
  field :provider, :type => String
  field :state, :type => Symbol

  belongs_to :account

  validates :pin, :presence => true, :numericality => true, :uniqueness => true
  validates :provider, :presence => true, :inclusion => { :in => AppConfig.providers }
  validates :state, :presence => true

  scope :loaded,   where(:state => :loaded)
  scope :assigned, where(:state => :assigned)

  workflow_column :state
  workflow do
    state :loaded do
      event :assign, :transitions_to => :assigned
    end
    state :assigned
  end

  def assign(account)
    self.account = account
  end

  def self.find_by_pin(pin)
    pin = pin.to_s[0..9].to_i rescue nil
    where(:pin => pin).limit(1).first
  end

end
