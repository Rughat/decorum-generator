class RenameGameToScenario < ActiveRecord::Migration[7.1]
  def change
    rename_table :games, :scenarios
  end
end
