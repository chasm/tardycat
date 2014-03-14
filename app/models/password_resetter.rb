class PasswordResetter

  SUCCESS = "We sent you an email with instructions for resetting your password."
  NO_MAIL = "Unable to send email. Please notify the webmaster."
  NO_SAVE = "Password reset failed. Please notify the webmaster."
  NO_USER = "Unable to log you in. Please check your email and password and try again."

  def initialize(flash)
    @flash = flash
  end

  def handle_reset_request(params)
    if @user = User.find_by( email: params[:email] )
      update_user_and_send_mail
    else
      @flash.now[:alert] = NO_USER
    end
  end

  def update_password(user, params)
    if user.reset_password( params )
      UserNotifier.password_was_reset( user ).deliver
      return true
    end
  end

  private

  def update_user_and_send_mail
    if @user.set_password_reset
      send_reset_email
    else
      @flash.now[:alert] = NO_SAVE
    end
  end

  def send_reset_email
    begin
      UserNotifier.reset_password(@user).deliver
      @flash.now[:notice] = SUCCESS
    rescue
      @flash.now[:alert] = NO_MAIL
    end
  end
end