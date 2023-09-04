class SessionsController < ApplicationController

  def new
  end

  def create
    @UserArray = User.where(email: params[:email_or_username]).or(User.where(username: params[:email_or_username]))
    @user = @UserArray[0]
    if @user && @user.authenticate(params[:password])
      session[@user.id]
      redirect_to(@user, notice: "Welcome back! #{@user.name}")
    else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
    end
  end

  def destroy
  end

end
