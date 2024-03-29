Given /^I am an active (user|account|agent) named "([^"]*)"$/ do |user_type, name|
  @name = name
  @password = 'password'
  @username = 'username'
  @email    = 'email@email.com'
  @user = Fabricate(user_type.to_sym, :username => @username, :name => @name,
                    :password => @password, :password_confirm => @password)
end

Given /^I am on the root page$/ do
  visit('/')
end

When /^I enter my authentication info$/ do
  fill_in('Username', :with => @username)
  fill_in('Password', :with => @password)
end

When /^click login$/ do
  click_link('Login')
end

Then /^I should see a welcome back message$/ do
  page.should have_content("Welcome back #{@name}!")
end

Given /^I am logged in$/ do
  visit('/')
  fill_in('Username', :with => @username)
  fill_in('Password', :with => @password)
  click_link('Login')
  page.should have_content("Welcome back #{@name}!")
end

When /^I click logout$/ do
  click_link('Logout')
end

Then /^I should see a take it easy message$/ do
  page.should have_content("See ya later dog!")
end

When /^I enter my bogus authentication info$/ do
  fill_in('Username', :with => 'bogus')
  fill_in('Password', :with => 'mcfogus')
end

Then /^I should see a firm rejection$/ do
  page.should have_content("Your info did not checkout dog")
end

