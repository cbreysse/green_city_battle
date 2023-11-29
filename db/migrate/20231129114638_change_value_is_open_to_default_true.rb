class ChangeValueIsOpenToDefaultTrue < ActiveRecord::Migration[7.1]
  def change
    change_column :spots, :is_open, :boolean, default: true, null: false
  end
end
