class EventType < ApplicationRecord
  has_many :events
  has_many :participations, through: :events
end
