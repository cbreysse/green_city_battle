class Event < ApplicationRecord
  belongs_to :spot
  belongs_to :event_type

  def formatted_date
    date_time = self.created_at 
    date_time.strftime("%e %B %Y")
  end
end
