Given /^I bought a kit with the pin (\d+)$/ do |pin|
  @pin = pin
  @provider_pin = Fabricate(:provider_pin, :pin => @pin)
  ProviderPin.count.should == 1
  @provider_pin.should be_loaded
end

Given /^I go to new enrollment page$/ do
  visit(new_enrollment_path)
end

When /^I enter my pin$/ do
  fill_in('Pin', :with => @pin)
end

When /^I push "([^"]*)"$/ do |button_name|
  click_button(button_name)
end

Then /^I will see a new form asking about me$/ do
  current_path.should == new_account_path
end

When /^I tell the form about me:$/ do |table|
  within('#new_account') do
    table.hashes.first.each_pair do |k, v|
      @name = v if k == 'Name'
      fill_in(k, :with => v)
    end
  end
end

When /^I swear that I read the terms and agree, ha$/ do
  within('#new_account') do
    check(:agree_to_terms)
  end
end

Then /^my account should be pending$/ do
  @account = Account.where(:name => @name).first
  @account.should be_a(Account)
  @account.state.should == :pending
end

Then /^my pin should be assigned to me$/ do
  @account.provider_pin.should == @provider_pin
end

Then /^my username should be my pin$/ do
  @account.username.to_s.should == @provider_pin.pin.to_s
end

Then /^I will be on some dashboard thingy page$/ do
  current_path.should == account_path(@account.id)
end

Then /^I will see something demanding I check my email$/ do
  page.should have_content 'We sent you an email, holla back yo!'
end

Then /^an email should be sent to me$/ do
  unread_emails_for(@account.email).size.should == 1
end

Then /^an email should be sent to the admins$/ do
  unread_emails_for(AppConfig.email['admin']).size.should == 1
end

Then /^I will be waiting on approval, hope it's quick$/ do
  @account.should be_pending
end

# downline enrollment specific steps
Given /^I bought a kit from Juan with the pin (\d+)$/ do |pin|
  @pin = pin
  @agent = Fabricate(:agent)
  @parent_pin = Fabricate(:provider_pin)
  @parent_account = Fabricate(:account,
                              :name => "Juan",
                              :username => @parent_pin.pin,
                              :agree_to_terms => DateTime.now)
  @parent_pin.assign!(@parent_account)
  @parent_account.approve!(@agent)
  @provider_pin = Fabricate(:provider_pin, :pin => @pin)
  @provider_pin.register!(@parent_account)
  reset_mailer
end

Given /^I go to the new enrollment page$/ do
  visit(new_enrollment_path)
end

Then /^my parent should be Juan$/ do
  @account = Account.where(:name => 'Jorge Diaz').first
  @account.should be_a(Account)
  @account.parent.should == @parent_account
end

Then /^I should be Juans child$/ do
  @parent_account.children.all.should include(@account)
end
