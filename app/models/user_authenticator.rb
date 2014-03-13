class UserAuthenticator

  def initialize(session, flash)
    @session = session
    @flash = flash
  end

  def authenticate_user(params)
    if @user = User.authenticate(params[:email], params[:password])
      @session[:user_id] = @user.id
    else
      @flash.now[:alert] = "Unable to log you in. Please check your email and password and try again."
    end
  end
end