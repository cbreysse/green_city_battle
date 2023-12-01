class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    spots = @team.spots
    participations = Participation.where(spot: spots)
    @total_points = participations.map { |p| p.action_type.points }.sum
  end
end
