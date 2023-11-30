class ParticipationsController < ApplicationController
  def new
    @spot = Spot.find(params[:spot_id])
    @participation = Participation.new
    @spot_action = params[:spot_action]
  end

  def create
  end
end
