Fabricator(:account) do
  name { Faker::Name.name }
  username { Faker::Internet.user_name }
  email { Faker::Internet.free_email }
  address { "#{Faker::Address.street_address} #{Faker::Address.city}, #{Faker::Address.us_state_abbr} #{Faker::Address.zip}" }
  phone { Faker::PhoneNumber.phone_number }
  id_type "DL"
  id_number { "#{(0..9).to_a.map{rand(9).to_s}.join}" }
  agree_to_terms { DateTime.now }
end
