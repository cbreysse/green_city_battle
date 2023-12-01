class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    spots = @team.spots
    participations = Participation.where(spot: spots)
    points = participations.map { |p| p.action_type.points }.sum
    raise
  end
end
