class TeamsController < ApplicationController

  def show
    @team = Team.find(params[:id])
    @teams = Team.all
  end
end
