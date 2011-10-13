class AccountsController < ApplicationController
  before_filter :find_provider_pin!, :only => [ :new ]
  def new
    @account = Account.new(:provider_pin => @provider_pin)
  end

  private
    def find_provider_pin!
      @provider_pin = ProviderPin.find(params[:provider_pin_id])
      unless @provider_pin
        flash[:error] = 'Pin not found!'
        return redirect_to new_enrollment_path
      end
    end
end
