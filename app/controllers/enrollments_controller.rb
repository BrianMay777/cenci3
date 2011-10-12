class EnrollmentsController < ApplicationController
  def new
    @pin = Pin.new
  end

  def create
    @pin = Pin.find_by_pin(:pin => params[:pin][:pin])
    if @pin.new_record?
      render :new
    else
      redirect_to new_account_path(@pin.pin)
    end
  end
end
