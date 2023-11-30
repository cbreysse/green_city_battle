class ParticipationsController < ApplicationController
  def show
    @participation = Participations.find(params[:id])
  end
end
