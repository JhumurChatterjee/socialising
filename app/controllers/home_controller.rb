class HomeController < ApplicationController
  before_action :authenticate_user!, only: :timeline

  def index
    redirect_to timeline_path if current_user
  end

  def timeline
    @locations = Location.visible(current_user.id)
    @pagy, @locations = pagy_countless(@locations.includes(:user), items: 21, link_extra: 'data-remote="true"')
  end
end
