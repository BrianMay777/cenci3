class ProviderPin
  include Mongoid::Document
  include Mongoid::Timestamps
  include Workflow

  field :pin, :type => Integer
  field :provider, :type => String
  field :state, :type => Symbol
  field :registered_at, :type => DateTime

  belongs_to :account
  belongs_to :registered_by, :class_name => 'Account', :inverse_of => :registered_pins

  validates :pin, :presence => true, :numericality => true, :uniqueness => true
  validates :provider, :presence => true, :inclusion => { :in => AppConfig.providers }
  validates :state, :presence => true

  scope :loaded,   where(:state => :loaded)
  scope :assigned, where(:state => :assigned)

  workflow_column :state
  workflow do
    state :loaded do
      event :assign,   :transitions_to => :assigned
      event :register, :transitions_to => :registered
    end
    state :registered do
      event :assign, :transitions_to => :assigned
    end
    state :assigned
  end

  def assign(account)
    self.account = account
  end

  def register(account)
    self.registered_by = account
    self.registered_at = DateTime.now
  end

  def self.find_by_pin(pin)
    pin = pin.to_s[0..9].to_i rescue nil
    where(:pin => pin).limit(1).first
  end

  def self.register_by_pin(pin, registered_by)
    pin = where(:pin => pin).first
    return false unless pin
    pin.register!(registered_by)
  end

end
