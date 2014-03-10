class SessionController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate( params[:user][:email], params[:user][:password] )

    if @user
      session[:user_id] = @user.id
      render text: "Logged you in!"
    else
      render text: "Who are you, really?"
    end
  end

  def destroy
    render text: "Log the user out."
  end
end