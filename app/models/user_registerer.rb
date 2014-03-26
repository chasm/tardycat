class UserRegisterer

  SUCCESS = %{ We sent you an email with instructions for
    completing your registration.}.squish

  MAIL_FAILED = "Unable to send email. Please notify the webmaster."
  SAVE_FAILED = "Registration failed. Please notify the webmaster."

  def initialize(flash)
    @flash = flash
  end

  def create_a_new_registrant(email)
    @registrant = Registrant.find_or_initialize_by( email: email )

    if @registrant.save
      puts "REGISTRANT IN create_a_new_registrant", @registrant
      send_registration_coded_link
    else
      @flash.now[:alert] = SAVE_FAILED
    end
  end

  private

  def send_registration_coded_link
    puts "REGISTRANT IN send_registration_coded_link", @registrant
    begin
      UserNotifier.coded_registration_link(@registrant).deliver

      @flash.now[:notice] = SUCCESS
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
      @flash.now[:alert] = MAIL_FAILED
    end
  end
end
