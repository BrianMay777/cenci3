class Account < User
  authenticates_with_sorcery!

  field :name, :type => String, :default => nil
  field :address, :type => String
  field :phone, :type => String
  field :id_type, :type => String
  field :id_number, :type => String
  field :agree_to_terms, :type => DateTime

  has_one :provider_pin

  validates :provider_pin, :presence => true

  def pin
    self.username
  end

  after_create :send_welcome_email!
  def send_welcome_email!
    AccountMailer.welcome_email(self).deliver
  end


end
