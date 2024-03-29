class SessionsController < ApplicationController
  def create
    user = login(params[:session][:username],
                 params[:session][:password],
                 params[:session][:remember_me])
    if user
      redirect_back_or_to user_path(user), :notice => "Welcome back #{user.name}!"
    else
      redirect_to new_enrollment_path, :alert => "Your info did not checkout dog!"
    end
  end

  def destroy
    logout
    redirect_to new_enrollment_path, :notice => 'See ya later dog!'
  end
end
