class LocationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to timeline_path, flash: { success: I18n.t("share_success") }
    else
      render "new"
    end
  end

  private

  def location_params
    params.require(:location).permit(:address, user_ids: []).merge(user: current_user)
  end
end
