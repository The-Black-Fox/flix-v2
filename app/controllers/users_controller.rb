class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]


  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to(@user, notice: "User succesfully created!")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # user find action is done in private method that runs before the edit view action is called.
  end

  def update
    fail
    if @user.update(user_params)
      redirect_to(@user, notice: "User succesfully Updated!")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to(@user, alert: "UsAccounter succesfully deleted!")
  end

  private

  def user_params
    params.require(:user)
      .permit(:name, :username, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user
      redirect_to root_path	, status: :see_other,  alert: "Error, user not authorized for this action"
    end
  end
end
