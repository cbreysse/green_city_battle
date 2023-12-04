class Spot < ApplicationRecord
  belongs_to :team
  has_many :participations, dependent: :destroy
  has_many :events
  has_one_attached :photo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
end
