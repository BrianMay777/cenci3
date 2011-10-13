Fabricator(:account) do
  username { Faker::Name.name }
  email { Faker::Internet.free_email }
  provider_pin
end
