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

  def send_welcome_email!
    AccountMailer.welcome_email(self).deliver
  end

  def send_account_pending_email!
    AdminMailer.account_pending_email(self).deliver
  end

  def self.approve_by_account_id(account_id, agent)
    account = find(account_id)
    raise "Account not found #{account_id}!" unless account
    account.approve!(agent)
    AccountMailer.approval_email(account).deliver
  end

end
