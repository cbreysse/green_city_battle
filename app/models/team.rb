class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :spots, dependent: :destroy
  has_many :participations, through: :spots
end
