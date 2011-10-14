Given /^I am an Agent named "([^"]*)" and I am logged in$/ do |name|
  @name = name
  @username = 'username'
  @password = 'password'
  @agent = Fabricate(:agent,
                     :username => @username,
                     :name => @name,
                     :password => @password,
                     :password_confirmation => @password)
  @agent.should be_valid
  visit('/')
  fill_in('Username', :with => @username)
  fill_in('Password', :with => @password)
  click_link('Login')
  page.should have_content("Welcome back #{@name}!")
end

Given /^someone named Juan I slung a kit to enrolled$/ do
  @account = Fabricate(:account, :name => "Juan", :approved_at => nil)
end

Given /^I go to my dashboard$/ do
  visit(agent_path(@agent))
end

Then /^I should see Juan in my list of people waiting for approval$/ do
  page.find("#pending_account_approval_form_#{@account.id}").should_not be_nil
end

When /^I click Approve next to Juan$/ do
  reset_mailer
  find_link("pending_account_approval_link_#{@account.id}").click
end

Then /^I should be on my dashboard$/ do
  current_path.should == agent_path(@agent.id)
end

Then /^I should see Juan in my list of approved accounts$/ do
  within("#approved_accounts") do
    page.should have_content(@account.name)
  end
end

Then /an email should be sent to Juan$/ do
  unread_emails_for(@account.email).size.should == 1
end
