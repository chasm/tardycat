class SessionController < ApplicationController

  def new
    redirect_to root_url, notice: "You are logged in." if current_user
  end

  def create
    @user = User.find_by( email: params[:user][:email] )

    if @user
      if params[:user][:password].blank?
        @user.set_password_reset
        UserNotifier.reset_password(@user).deliver
        flash.now[:notice] = "We sent you an email with instructions for resetting your password."
        render :new
      elsif @user.authenticate( params[:user][:password] )
        session[:user_id] = @user.id
        redirect_to root_url
      else
        flash.now[:alert] = "Unable to log you in. Please check your email and password and try again."
        render :new
      end
    else
      flash.now[:alert] = "Unable to log you in. Please check your email and password and try again."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url, notice: "You've successfully logged out."
  end
end