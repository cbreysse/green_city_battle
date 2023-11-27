class AddIsOpenToSpots < ActiveRecord::Migration[7.1]
  def change
    add_column :spots, :is_open, :boolean
  end
end
