class Account < User

  field :name, :type => String, :default => nil
  field :address, :type => String
  field :phone, :type => String
  field :id_type, :type => String
  field :id_number, :type => String

  has_one :provider_pin

  validates :provider_pin, :presence => true

  def pin
    self.username
  end

  after_initialize :set_pin
  def set_pin
    self.username ||= self.provider_pin.pin
  end

end
