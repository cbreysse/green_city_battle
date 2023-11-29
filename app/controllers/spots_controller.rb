class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @markers = Spot.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude
      }
    end
    @user_marker = render_to_string(partial: "spots/user_marker")
  end
end
