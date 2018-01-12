class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @events = @user.events.all
  end

  def login
    if (@user = User.find_by(email: params[:user][:email]))
      session[:user_id] = @user.id
      flash[:sucess] = "You are now logged in as #{current_user.name}."
      redirect_to @user
    else
      flash.now[:danger] = 'Login unsuccessful.'
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
