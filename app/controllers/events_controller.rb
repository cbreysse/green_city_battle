class EventsController < ApplicationController
  def show
    @event = Event.find(params[:id])
    @event_type = @event.event_type
    @formatted_date = @event.formatted_date
  end

end
