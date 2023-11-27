class Participation < ApplicationRecord
  belongs_to :action_type
  belongs_to :user
  belongs_to :event
end
