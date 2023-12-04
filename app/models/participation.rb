class Participation < ApplicationRecord
  belongs_to :action_type, optional: true
  belongs_to :user
  belongs_to :event, optional: true
  belongs_to :spot
  belongs_to :event_type, optional: true
  has_one_attached :photo
end
