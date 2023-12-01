class Participation < ApplicationRecord
  has_one :action_type
  belongs_to :user
  belongs_to :event, optional: true
  belongs_to :spot
  has_one_attached :photo
end
