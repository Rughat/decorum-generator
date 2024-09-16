class AddReferencesToTokens < ActiveRecord::Migration[7.1]
  def change
    add_reference :tokens, :room, null: false, foreign_key: true
  end
end
