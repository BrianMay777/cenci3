Fabricator(:agent) do
  username { Faker::Internet.user_name }
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
end
