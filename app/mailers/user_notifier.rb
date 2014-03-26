class UserNotifier < ActionMailer::Base
  default from: "ToddyCat <webmaster@toddycat.com>"

  CODED_RESET_LINK          = "[ToddyCat] Reset your credentials"
  PASSWORD_WAS_RESET        = "[ToddyCat] Your password has been reset!"
  CODED_REGISTRATION_LINK   = "[ToddyCat] Complete your registration"

  def coded_password_reset_link(user)
    @user = user

    mail to: @user.email, subject: CODED_RESET_LINK
  end

  def password_was_reset(user)
    @user = user

    mail to: @user.email, subject: PASSWORD_WAS_RESET
  end

  def coded_registration_link(registrant)
    @registrant = registrant

    mail to: @registrant.email, subject: CODED_REGISTRATION_LINK
  end
end
