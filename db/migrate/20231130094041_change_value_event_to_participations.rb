class ChangeValueEventToParticipations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :participations, :event_id, true
  end
end
