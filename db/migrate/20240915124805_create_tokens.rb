class CreateTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :tokens do |t|
      t.string :type
      t.string :color
      t.timestamps
    end
  end
end
