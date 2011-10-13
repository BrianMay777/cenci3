class SessionsController < ApplicationController
  def create
    user = login(params[:session][:username],
                 params[:session][:password],
                 params[:session][:remember_me])
    if user
      redirect_back_or_to root_url, :notice => "Welcome back #{user.name}!"
    else
      redirect_to root_url, :alert => "Your info did not checkout dog!"
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => 'See ya later dog!'
  end
end
