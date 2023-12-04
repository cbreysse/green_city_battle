class EventType < ApplicationRecord
  has_many :participations, through: :events
  has_many :events
end
