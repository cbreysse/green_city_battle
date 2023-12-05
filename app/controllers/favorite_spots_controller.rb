class FavoriteSpotsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def index
    @favorite_spots = current_user.spots
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @favorite_spot = FavoriteSpot.new
    @favorite_spot.spot = @spot
    @favorite_spot.user = current_user
    @favorite_spot.save
    respond_to do |format|
      format.html { redirect_to @spot, notice: 'Spot ajouté aux favoris!' }
      format.json do
        render json: { heart_html: render_to_string(partial: "spots/heart", locals: { spot: @spot }, formats: :html) }
      end
    end
  end

  def destroy
    @favorite_spot = FavoriteSpot.find(params[:id])
    @favorite_spot.destroy
    respond_to do |format|
      format.html { redirect_to @spot, notice: 'Spot ajouté aux favoris!' }
      format.json do
        render json: { heart_html: render_to_string(partial: "spots/heart", locals: { spot: @favorite_spot.spot }, formats: :html) }
      end
    end
  end
end
