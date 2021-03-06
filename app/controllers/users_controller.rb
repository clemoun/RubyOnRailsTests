class UsersController < ApplicationController

  def show
    unless logged_in? && @current_user.id == params[:id].to_i
      flash[:info] = "Il faut te connecter, petit malin!"
      redirect_to login_path
    end
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Compte créé pour #{@user.first_name}"
      log_in(@user)
      redirect_to root_path
    else
      render "new"
    end
  end

  def index
    unless logged_in?
      flash[:info] = "Merci de vous connecter, petit malin..."
      redirect_to login_path
    end
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
