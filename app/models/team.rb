class Team < ApplicationRecord
  has_many :users, :spots
end
