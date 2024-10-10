class UpdateGameReferencesToScenario < ActiveRecord::Migration[7.1]
  def change
    rename_column :players, :game_id, :scenario_id
  end
end
