class TeamsController < ApplicationController
  def show
    @team = Team.find(params[:id])
    @teams = Team.all
    # @teams = Team.all.sort_by { |team| team.score }.reverse ##changer team.score par la fonction implementée par la logique de calcul
  end
end
