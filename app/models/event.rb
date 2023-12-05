class Event < ApplicationRecord
  belongs_to :spot
  belongs_to :event_type
  has_many :participations
  has_many :users, through: :participations

  def formatted_date
    date_time = self.created_at
    date_time.strftime("%e %B %Y")
  end
end
