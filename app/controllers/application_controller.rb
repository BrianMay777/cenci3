class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_agent
    redirect_to root_url, :alert => 'You must be an agent to view this page' unless current_user.agent?
  end

  def user_path(user)
    send "#{user._type.downcase}_path", user
  end

  def current_user_path
    user_path(current_user)
  end

end
