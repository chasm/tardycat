class UserNotifier < ActionMailer::Base
  default from: "ToddyCat <webmaster@toddycat.com>"

  CODED_RESET_LINK_SUBJCT    = "[ToddyCat] Reset your credentials"
  PASSWORD_WAS_RESET_SUBJECT = "[ToddyCat] Your password has been reset!"

  def coded_password_reset_link(user)
    @user = user

    mail to: @user.email, subject: CODED_RESET_LINK_SUBJCT
  end

  def password_was_reset(user)
    @user = user

    mail to: @user.email, subject: PASSWORD_WAS_RESET_SUBJECT
  end
end
