class Participation < ApplicationRecord
  belongs_to :action_type
  belongs_to :user
  belongs_to :event, optional: true
  belongs_to :spot
  # belongs_to :team
  has_one_attached :photo
end
