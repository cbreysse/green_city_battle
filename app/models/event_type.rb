class EventType < ApplicationRecord
  has_many :participations
  has_many :events
end
