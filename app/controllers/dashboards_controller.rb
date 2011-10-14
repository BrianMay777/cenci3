class DashboardsController < ApplicationController

  def index
    return redirect_to current_user_path if logged_in?
    redirect_to new_enrollment_path
  end

end
