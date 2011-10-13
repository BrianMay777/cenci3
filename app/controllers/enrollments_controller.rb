class EnrollmentsController < ApplicationController
  def new
    @provider_pin = ProviderPin.new
  end

  def create
    @provider_pin = ProviderPin.find_by_pin(params[:provider_pin][:pin])
    unless @provider_pin
      render :new
    else
      redirect_to new_account_path(:provider_pin_id => @provider_pin.id)
    end
  end
end
