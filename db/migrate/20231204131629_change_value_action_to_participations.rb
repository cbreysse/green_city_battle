class ChangeValueActionToParticipations < ActiveRecord::Migration[7.1]
  def change
    change_column_null :participations, :action_type_id, true
  end
end
