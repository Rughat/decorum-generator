class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end

    create_table :requirements do |t|
      t.references :player, null: false, foreign_key: true

      t.timestamps
    end
  end
end
