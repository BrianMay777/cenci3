class AccountMailer < ActionMailer::Base
  default from: AppConfig.email['from']

  def welcome_email(account)
    @account = account
    return if @account.email.blank?
    @account_url = account_path(@account)
    mail(:to => @account.email, :subject => 'Welcome to Cenciyo - Pending Approval')
  end

  def approval_email(account)
    @account = account
    return if @account.email.blank?
    @account_url = account_path(@account)
    mail(:to => @account.email, :subject => 'Welcome to Cenciyo - Account Approved')
  end
end
