class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!


  field :username, :type => String, :default => nil
  field :email, :type => String, :default => nil
  field :crypted_password, :type => String
  field :salt, :type => String
  field :remember_me_token, :type => String, :default => nil
  field :remember_me_token_expires, :type => DateTime, :default => nil

  validates :username, :presence => true, :uniqueness => true
  validates :email, :uniqueness => true
  validates :crypted_password, :presence => true
  validates :salt, :presence => true

end
