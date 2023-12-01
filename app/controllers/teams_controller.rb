class TeamsController < ApplicationController
  def show
    @team = current_user.team
    @my_team_total_points = calculate_total_points(Participation.where(spot: @team.spots))

    all_teams_participations = Participation.joins(:spot).where(spots: { team: Team.all })
    @total_points_by_team = calculate_total_points_by_team(all_teams_participations)
  end

  private

  def calculate_total_points(participations)
    participations.map { |p| p.action_type.points }.sum
  end

  def calculate_total_points_by_team(participations)
    participations.group_by { |p| p.spot.team }.transform_values do |team_participations|
      calculate_total_points(team_participations)
    end
  end
end
