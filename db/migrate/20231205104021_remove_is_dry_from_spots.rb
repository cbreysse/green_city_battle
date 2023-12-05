class RemoveIsDryFromSpots < ActiveRecord::Migration[7.1]
  def change
    remove_column :spots, :is_dry, :boolean
  end
end
