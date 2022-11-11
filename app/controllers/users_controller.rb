class UsersController < ApplicationController
  before_action :logged_user, only: [ :new, :create ]

  def new
    @user = User.new
    @errors = session[:user_error]
    session[:user_error]= nil
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = "Account succesfully created, Welcome!"
      redirect_to root_path
    else
      session[:user_error] = @user.errors.full_messages
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
