class Event < ApplicationRecord
  belongs_to :spot
  belongs_to :event_type
end
