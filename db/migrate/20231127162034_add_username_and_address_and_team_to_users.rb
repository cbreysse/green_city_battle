class AddUsernameAndAddressAndTeamToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :address, :string
    add_reference :users, :team, null: false, foreign_key: true
  end
end
