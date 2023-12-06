class SpotsController < ApplicationController
  include ActionIntervals
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @markers = spot_hash
    @user_marker = render_to_string(partial: "spots/user_marker")
  end

  def show
    @spot = Spot.find(params[:id])
    @last_participations = @spot.not_event_participations.order(created_at: :desc).first(2)
    respond_to do |format|
      format.text { render(partial: "spots/spot_details", locals: { spot: @spot }, formats: [:html]) }
    end
  end

  private

  def spot_hash
    Spot.geocoded.map do |spot|
      {
        lat: spot.latitude,
        lng: spot.longitude,
        id: spot.id,
        name: spot.name,
        address: spot.address,
        marker_html: render_to_string(partial: "shared/marker", locals: { img: spot_marker(spot) })
      }
    end
  end

  def spot_marker(spot)
    if spot.is_open?
      if plant_dry?(spot)
        'plant_dying.png'
      else
        'plant.png'
      end
    else
      'raid.png'
    end
  end
end
