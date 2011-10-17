Given /^I am an enrolled approved account named "([^"]*)"$/ do |name|
  @name = name
  @password = 'password'
  @agent = Fabricate(:agent)
  @account_pin = Fabricate(:provider_pin)
  @account = Fabricate(:account,
                       :name => @name,
                       :username => @account_pin.pin,
                       :password => @password,
                       :password_confirmation => @password,
                       :agree_to_terms => DateTime.now)
  @account_pin.assign!(@account)
  @account.approve!(@agent)
  @buddies_pin = Fabricate(:provider_pin)
end

Given /^I am logged in and on my dashboard$/ do
  visit('/')
  fill_in('Username', :with => @account_pin.pin)
  fill_in('Password', :with => @password)
  click_link('Login')
  page.should have_content("Welcome back #{@name}!")
  current_path.should == account_path(@account)
end

When /^I enter my buddies pin into the register form$/ do
  within('#registered_pins') do
    fill_in('Pin', :with => @buddies_pin.pin)
  end
end

When /^I click register$/ do
  within('#registered_pins') do
    click_link('Register')
  end
end

Then /^I should be told that my buddies pin has been registered$/ do
  page.should have_content("Thank you for registering a pin #{@account.name}!")
end

Then /^my I should see my buddies pin in my list of registered pins$/ do
  within('#registered_pins') do
    page.should have_content(@buddies_pin.pin)
  end
end
