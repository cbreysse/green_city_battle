class ParticipationsController < ApplicationController
  skip_before_action :authenticate_user!, only: :time_until_next_action
  include ActionIntervals

  def new
    @spot = Spot.find(params[:spot_id])
    @participation = Participation.new
    @spot_action = params[:spot_action]
  end

  def create
    @spot = Spot.find(params[:spot_id])
    @participation = Participation.new(participation_params)
    @event = @participation.event
    configure_participation(@participation)

    if current_user_already_participating?
      flash.now.alert = "Vous participez déjà à cet événement."
      render :new, status: :unprocessable_entity
    elsif @participation.save
      redirection_path = @event.present? ? event_path(@event) : participation_path(@participation)
      redirect_to redirection_path
    else
      flash.alert = @participation.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @participation = Participation.find(params[:id])
  end

  def time_until_next_action
    action = ActionType.find(params[:action_id])
    spot = Spot.find(params[:spot_id])
    last_action = Participation.where(spot_id: spot.id, action_type_id: action.id).last
    if last_action
      last_action_timestamp = last_action.created_at
      action_name = action.name

      if ActionIntervals::INTERVALS_MAPPING.key?(action_name)
        next_possible_action_timestamp = last_action_timestamp + ActionIntervals::INTERVALS_MAPPING[action_name]
        render json: { next_possible_action_timestamp: next_possible_action_timestamp }
      else
        render json: { error: "Action interval not defined in the mapping" }, status: :unprocessable_entity
      end
    else
      render json: { error: "No previous action found" }, status: :unprocessable_entity
    end
  end

  private

  def participation_params
    params.require(:participation).permit(:action_type, :photo, :event_id)
  end

  def configure_participation(participation)
    participation.spot = @spot
    participation.user = current_user
    participation.action_type = ActionType.find(params[:action_type]) unless @event.present?
  end

  def current_user_already_participating?
    @event.present? && current_user.participations.exists?(event: @event)
  end
end
