class PasswordController < ApplicationController

  def edit
    @user = User.find_by_code params[:code]

    redirect_to login_url, notice: "Sorry, your reset link has expired. Please generate a new one." unless @user
  end

  def update
    @user = User.find_by_code params[:code]

    if @user
      if params[:user][:password].blank?
        @user.errors.add( :password, "can't be blank" )
        render text: @user.errors.messages
      elsif @user.update_attributes user_params
        render text: "Success!"
      else
        render text: "Failure!"
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