class RegistrationController < ApplicationController

  REGISTRANT_NOT_FOUND = %{
    Registration code not found or expired.
    Please try again.
  }.squish

  def new
  end

  def create
  end

  private

  def get_registrant
    unless @registrant = Registrant.find_by_code( params[:code] )
      redirect_to login_form_url, alert: REGISTRANT_NOT_FOUND
    end
  end
end
