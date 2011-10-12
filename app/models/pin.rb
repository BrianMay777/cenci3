class Pin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :pin, :type => Integer
  field :provider, :type => String

  validates :pin, :presence => true, :numericality => true, :uniqueness => true
  validates :provider, :presence => true, :inclusion => { :in => AppConfig.providers }

  def self.find_by_pin(pin)
    Pin.where(:pin => pin).limit(1).first || pin_not_found
  end

  def self.pin_not_found
    pin = Pin.new
    pin.errors[:pin] << 'Pin not found!'
    pin
  end
end
