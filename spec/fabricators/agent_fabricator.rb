Fabricator(:agent) do
  username { Faker::Internet.username }
  name { Faker::Name.name }
  password 'password'
  password_confirmation 'password_confirmation'
end
