class HomeController < ApplicationController
  before_action :authenticate_user!, only: :timeline

  def index
    redirect_to timeline_path if current_user
  end

  def timeline
    @locations = Location.visible(current_user.id).includes(:user)
  end
end
