class SessionController < ApplicationController

  def new
  end

  def create
    render text: "Log #{params[:user][:email]} in with #{params[:user][:password]}."
  end

  def destroy
    render text: "Log the user out."
  end
end