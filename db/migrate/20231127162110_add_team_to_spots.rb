class AddTeamToSpots < ActiveRecord::Migration[7.1]
  def change
    add_reference :spots, :team, null: false, foreign_key: true
  end
end
