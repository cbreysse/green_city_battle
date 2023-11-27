class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :spot, null: false, foreign_key: true
      t.datetime :occurs_at
      t.string :description

      t.timestamps
    end
  end
end
