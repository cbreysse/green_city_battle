class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @event_type = @event.event_type
    @formatted_date = @event.formatted_date
    @current_user_is_participating = @event.participations.find_by(user: current_user)

    
  end

end
