class FixGameHouseColumnsToIds < ActiveRecord::Migration[7.1]
  def change
    rename_column :games, :starting_layout, :starting_layout_id
    rename_column :games, :goal_layout, :goal_layout_id
  end
end
