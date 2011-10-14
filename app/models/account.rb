class Account < User
  authenticates_with_sorcery!

  field :address, :type => String
  field :phone, :type => String
  field :id_type, :type => String
  field :id_number, :type => String
  field :agree_to_terms, :type => DateTime
  field :approved_at, :type => DateTime

  has_one :provider_pin

  validates :provider_pin, :presence => true

  scope :pending_approval, where(:approved_at => nil)
  scope :approved, where(:approved_at.ne => nil)

  def pin
    self.username
  end

  after_create :send_welcome_email!
  after_create :send_account_pending_email!

  def send_welcome_email!
    AccountMailer.welcome_email(self).deliver
  end

  def send_account_pending_email!
    AdminMailer.account_pending_email(self).deliver
  end

  def active?
    !approved_at.nil?
  end

  def self.approve_by_account_id(account_id)
    account = find(account_id)
    raise "Account not found #{account_id}!" unless account
    account.update_attribute(:approved_at, DateTime.now)
    AccountMailer.approval_email(account).deliver
  end

end
