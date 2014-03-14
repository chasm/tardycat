class PasswordResetter

  SUCCESS = %{ We sent you an email with instructions for
    resetting your password.}.squish

  USER_NOT_FOUND = %{ Unable to log you in. Please check your email
    and password and try again.}.squish

  MAIL_FAILED = "Unable to send email. Please notify the webmaster."
  SAVE_FAILED = "Password reset failed. Please notify the webmaster."



  def initialize(flash)
    @flash = flash
  end

  def handle_reset_request(user_params)
    if @user = User.find_by( email: user_params[:email] )
      set_reset_code_and_notify_user
    else
      @flash.now[:alert] = USER_NOT_FOUND
    end
  end

  def update_password(user, user_params)
    if user.reset_password( user_params )
      begin
        UserNotifier.password_was_reset( user ).deliver
      rescue
        # Mail didn't send
      end

      return true
    end
  end

  private

  def set_reset_code_and_notify_user
    if @user.set_reset_code
      send_password_reset_coded_link
    else
      @flash.now[:alert] = SAVE_FAILED
    end
  end

  def send_password_reset_coded_link
    begin
      UserNotifier.coded_password_reset_link(@user).deliver

      @flash.now[:notice] = SUCCESS
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      @flash.now[:alert] = MAIL_FAILED
    end
  end
end
