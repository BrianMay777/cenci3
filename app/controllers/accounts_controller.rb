class AccountsController < ApplicationController
  before_filter :find_provider_pin!, :only => [ :new ]
  before_filter :normalize_agree_to_terms!, :only => [ :create ]
  before_filter :require_login, :only => [ :show ]
  before_filter :require_agent, :only => [ :approve ]

  def new
    @account = Account.new(:provider_pin => @provider_pin)
  end

  def create
    @provider_pin = ProviderPin.find(params[:account].delete(:provider_pin))
    @account = Account.new(params[:account])
    unless @account.save
      render :new
    else
      @provider_pin.assign!(@account)
      auto_login @account
      flash[:notice] = "Thank you for enrolling #{@account.name}!"
      flash[:notice] << 'We sent you an email, holla back yo!' unless @account.email.blank?
      redirect_to account_path(@account)
    end
  end

  def show
  end

  def approve
    Account.approve_by_account_id(params[:account_id], current_user)
    redirect_to user_path(current_user)
  end

  private

    def find_provider_pin!
      @provider_pin = ProviderPin.find(params[:provider_pin_id])
      unless @provider_pin
        flash[:error] = 'Pin not found!'
        return redirect_to new_enrollment_path
      end
    end

    def normalize_agree_to_terms!
      agree_to_terms = params[:account].delete(:agree_to_terms)
      params[:account][:agree_to_terms] = [ true, 1, '1' ].include?(agree_to_terms) ? DateTime.now : nil
    end

end
