class AddSpotToParticipations < ActiveRecord::Migration[7.1]
  def change
    add_reference :participations, :spot, null: false, foreign_key: true
  end
end
