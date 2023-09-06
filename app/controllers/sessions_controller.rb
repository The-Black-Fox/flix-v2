class SessionsController < ApplicationController

  def new
  end

  def create
    @UserArray = User.where(email: params[:email_or_username]).or(User.where(username: params[:email_or_username]))
    @user = @UserArray[0]
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to( session[:intended_url] || @user, notice: "Welcome back! #{@user.name}")
      session[:intended_url] = nil
    else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, status: :see_other, notice: "You're now signed out!"
  end

end
