class ApplicationController < ActionController::Base

  helper_method :require_login, :logged_in?, :current_user, :current_user_username

  def require_login 
    unless session.include? :user_id 
      redirect_to '/'
    end
  end

  def logged_in?
    current_user != nil
  end

  def current_user
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end

  def current_user_username
    if session[:user_id]
      @user = User.find(session[:user_id])
      @user.name
    end
  end


end
