class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user
  def current_user
    @current_user||= User.find(session[:user_id])
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def require_user
    if !logged_in?
      flash[:warning]= "You need to be logged in to perform that action"
      redirect_to login_path
    end
  end

  def logged_user
    if logged_in?
      flash[:warning] = "You need to signout to perform that action"
      redirect_to root_path
    end
  end

end
