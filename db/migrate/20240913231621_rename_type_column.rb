class RenameTypeColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :rooms, :type, :room_type
  end
end
