class UserAuthenticator
  AUTH_FAILED = "Unable to log you in. Please check your email and password and try again."

  def initialize(flash)
    @flash = flash
  end

  def authenticate_user(params)
    @flash.now[:alert] = AUTH_FAILED unless @user = User.authenticate( params[:email], params[:password] )
    @user
  end
end