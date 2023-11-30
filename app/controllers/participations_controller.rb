class ParticipationsController < ApplicationController
  def new
    @spot = Spot.find(params[:spot_id])
    @participation = Participation.new
    @spot_action = params[:spot_action]
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @participation = Participation.new(participation_params)
    configure_participation(@participation)
    if @participation.save
      redirect_to participation_path(@participation)
    else
      flash.alert = @participation.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @participation = Participation.find(params[:id])
  end

  private

  def participation_params
    params.require(:participation).permit(:action_type, :photo)
  end

  def configure_participation(participation)
    participation.spot = @spot
    participation.user = current_user
    participation.action_type = ActionType.find(params[:action_type])
  end
end
