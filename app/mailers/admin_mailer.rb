class AdminMailer < ActionMailer::Base
  default from:    AppConfig.email['from'],
          to:      AppConfig.email['admin'],
          subject: '[Cenciyo] a new account is pending approval'

  def account_pending_email(account)
    @account = account
    return if @account.email.blank?
    @account_url = account_path(@account)
    mail
  end
end
