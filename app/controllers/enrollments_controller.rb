class EnrollmentsController < ApplicationController
  def new
    @provider_pin = ProviderPin.new
  end

  def create
    @provider_pin = ProviderPin.find_by_pin(:pin => params[:provider_pin][:pin][0..9])
    if @provider_pin.new_record?
      render :new
    else
      redirect_to new_account_path(@provider_pin.pin)
    end
  end
end
