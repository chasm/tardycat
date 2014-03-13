class PasswordController < ApplicationController
  LINK_EXPIRED = "Sorry, your reset link has expired. Please generate a new one."

  def edit
    unless @user = User.find_by_code( params[:code] )
      redirect_to login_url, notice: LINK_EXPIRED
    end
  end

  def update
    @user = User.find_by_code params[:code]

    if @user
      if params[:user][:password].blank?
        @user.errors.add( :password, "can't be blank" )
        flash.now[:alert] = @user.errors
        render :edit
      elsif @user.reset_password( user_params )
        session[:user_id] = @user.id
        UserNotifier.password_was_reset(@user).deliver
        redirect_to root_url, notice: "Your password has been successfully reset."
      else
        flash.now[:alert] = @user.errors
        render :edit
      end
    else
      render text: "No code or code expired."
    end
  end

  private

  def user_params
    params.require(:user).permit( :password, :password_confirmation )
  end
end