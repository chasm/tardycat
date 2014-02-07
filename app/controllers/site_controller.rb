class SiteController < ApplicationController

  def index
    @users = User.all.entries
  end

  def privacy
  end

  def terms
  end
end