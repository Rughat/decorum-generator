class AddDirectFurnishingsToRoom < ActiveRecord::Migration[7.1]
  def change
    add_reference :rooms, :lamp, foreign_key: { to_table: :tokens }
    add_reference :rooms, :curio, foreign_key: { to_table: :tokens }
    add_reference :rooms, :wall_hanging, foreign_key: { to_table: :tokens }
  end
end
