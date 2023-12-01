class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    spots = @team.spots
    participations = Participation.where(spot: spots)
  end
end
