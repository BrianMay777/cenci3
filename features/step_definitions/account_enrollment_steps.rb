Given /^I bought a kit with the pin (\d+)$/ do |pin|
  @provider_pin = Fabricate(:provider_pin, :pin => pin)
  ProviderPin.count.should == 1
end

Given /^I go to new enrollment page$/ do
  visit(new_enrollment_path)
end

When /^I enter my pin$/ do
  fill_in('Pin', :with => @provider_pin.pin)
end

When /^I push "([^"]*)"$/ do |button_name|
  click_button(button_name)
end

Then /^I will see a new form asking about me$/ do
  current_path.should == new_account_path
end

When /^I tell the form about me:$/ do |table|
  table.hashes.first.each_pair do |k, v|
    fill_in(k, :with => v)
  end
end

When /^I swear that I read the terms and agree, ha$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be on some dashboard thingy page$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will see something demanding I check my email$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^an email should be sent to me$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^an email should be sent to the admins$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I will be waiting on approval, hope it's quick$/ do
  pending # express the regexp above with the code you wish you had
end


