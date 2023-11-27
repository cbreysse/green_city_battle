class CreateActionTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :action_types do |t|
      t.string :name
      t.integer :points

      t.timestamps
    end
  end
end
