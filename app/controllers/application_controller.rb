class ApplicationController < ActionController::Base
  helper_method :logged_in?, :current_user, :current_chatroom, :add_to_chatroom
  def current_user
    @current_user||= User.find(session[:user_id])
  end

  def current_chatroom
    @current_chatroom||= Chatroom.find_by(id: session[:chatroom_id])
  end

  def user_chatrooms(number= nil)
    @chatrooms||= number.nil?  ? current_user.chatrooms : current_user.chatrooms.limit(number).recent
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
      redirect_to "/chatroom"
    end
  end

  def is_chatroom_member
    if !(session[:chatroom_id].nil?) && user_chatrooms.find_by(id: session[:chatroom_id]).nil?
      flash[:warning] = "You are not a member of that chatroom"
      redirect_to chatrooms_path
    end
  end

end
