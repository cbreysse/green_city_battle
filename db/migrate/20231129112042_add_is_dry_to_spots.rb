class AddIsDryToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :is_dry, :boolean, default: false
  end
end
