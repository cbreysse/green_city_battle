class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @markers = Spot.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        spot: { id: spot.id, name: spot.name, address: spot.address }
      }
    end
    @user_marker = render_to_string(partial: "spots/user_marker")
  end

  def show
    @spot = Spot.find(params[:id])
    respond_to do |format|
      format.text { render(partial: "spots/spot_details", locals: { spot: @spot }, formats: [:html]) }
    end
  end
end
