Fabricator(:user) do
  name { Faker::Name.name }
  username { Faker::Internet.username }
  email { Faker::Internet.free_email }
  password 'password'
  password_confirmation 'password'
end
