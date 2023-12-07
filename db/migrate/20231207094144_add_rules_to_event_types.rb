class AddRulesToEventTypes < ActiveRecord::Migration[7.1]
  def change
    add_column :event_types, :rules, :string
  end
end
