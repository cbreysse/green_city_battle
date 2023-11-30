class ParticipationsController < ApplicationController
  def show
    @participation = Participation.find(params[:id])
  end
end
