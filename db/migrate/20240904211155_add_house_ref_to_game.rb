class AddHouseRefToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :starting_layout, :integer
    add_column :games, :goal_layout, :integer
  end
end
