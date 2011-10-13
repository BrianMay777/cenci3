class User
  include Mongoid::Document
  include Mongoid::Timestamps
  authenticates_with_sorcery!


  field :username, :type => String, :default => nil
  field :email, :type => String, :default => nil

  validates :username, :presence => true, :uniqueness => true
  validates :email, :uniqueness => true

end
