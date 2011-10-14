Fabricator(:agent) do
  username { Faker::Internet.username }
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password 'password'
  password_confirmation 'password'
end
