class SessionsController < ApplicationController
  before_action :logged_user, only: [ :new, :create ]
  before_action :require_user, only: [ :destroy ]

  def new
  end

  def create
    login_info = login_params
    user = User.find_by(username: login_info[:username])

    if user && user.authenticate(login_info[:password])
      session[:user_id] = user.id
      flash[:info] = "Successfully logged in, welcome #{user.username}"
      redirect_to root_path
    else
      flash.now[:warning] = "Incorrect username or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "Succesfully logged out"
    redirect_to root_path
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end
