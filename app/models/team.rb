class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :spots, dependent: :destroy
end
