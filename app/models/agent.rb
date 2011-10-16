class Agent < User
  authenticates_with_sorcery!
  has_many :approved_accounts, :class_name => 'Account', :inverse_of => :approved_by
end

