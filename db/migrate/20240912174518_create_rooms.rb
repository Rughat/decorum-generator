class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.references :house, null: false, foreign_key: true
      t.string :type
      t.string :side
      t.string :floor
      t.string :color

      t.timestamps
    end
  end
end
