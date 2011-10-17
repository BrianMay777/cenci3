class Account < User
  include Workflow
  authenticates_with_sorcery!

  field :address, :type => String
  field :phone, :type => String
  field :id_type, :type => String
  field :id_number, :type => String
  field :agree_to_terms, :type => DateTime
  field :approved_at, :type => DateTime
  field :state, :type => Symbol

  has_one    :provider_pin
  has_many   :registered_pins, :class_name => 'ProviderPin', :inverse_of => :registered_by
  belongs_to :approved_by, :class_name => 'Agent', :inverse_of => :approved_accounts

  belongs_to :parent,   :class_name => 'Account', :inverse_of => :children
  has_many   :children, :class_name => 'Account', :inverse_of => :parent

  validates :address, :presence => true
  validates :phone, :presence => true
  validates :id_type, :presence => true
  validates :id_number, :presence => true
  validates :agree_to_terms, :presence => true
  validates :state, :presence => true

  scope :pending,  where(:state => :pending)
  scope :approved, where(:state => :approved)

  workflow_column :state
  workflow do
    state :pending do
      event :approve, :transitions_to => :approved
    end
    state :approved
  end

  def approve(agent)
    self.approved_by = agent
    self.approved_at = DateTime.now
  end

  def pin
    self.username
  end

  after_create :send_welcome_email!
  after_create :send_account_pending_email!
  before_save  :update_geneology!

  def send_welcome_email!
    AccountMailer.welcome_email(self).deliver
  end

  def send_account_pending_email!
    AdminMailer.account_pending_email(self).deliver
  end

  def update_geneology!
    return unless self.parent.nil?
    return if self.provider_pin.nil?
    return if self.provider_pin.registered_by.nil?
    self.parent = self.provider_pin.registered_by
  end

  def self.approve_by_account_id(account_id, agent)
    account = find(account_id)
    raise "Account not found #{account_id}!" unless account
    account.approve!(agent)
    AccountMailer.approval_email(account).deliver
  end

  def self.create_with_provider_pin(account_params)
    provider_pin = ProviderPin.find(account_params.delete(:provider_pin))
    account = new(account_params)
    return account unless account.save
    return account unless provider_pin.assign!(account)
    unless provider_pin.registered_by.nil?
      provider_pin.registered_by.children << account
    end
    account.save
    account
  end

end
