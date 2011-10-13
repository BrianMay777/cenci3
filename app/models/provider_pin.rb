class ProviderPin
  include Mongoid::Document
  include Mongoid::Timestamps

  field :pin, :type => Integer
  field :provider, :type => String

  belongs_to :account

  validates :pin, :presence => true, :numericality => true, :uniqueness => true
  validates :provider, :presence => true, :inclusion => { :in => AppConfig.providers }

  def self.find_by_pin(pin)
    pin = pin.to_s[0..9].to_i rescue nil
    where(:pin => pin).limit(1).first
  end

end
