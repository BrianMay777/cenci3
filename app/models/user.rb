class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!

  field :name, :type => String
  field :username, :type => String
  field :email, :type => String, :default => nil

  validates :name, :presence => true
  validates :username, :presence => true, :uniqueness => true
  validates :email, :uniqueness => true

  def agent?
    self._type == 'Agent'
  end

  def account?
    self._type == 'Account'
  end

end
