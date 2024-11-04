class AddRatingsToScenario < ActiveRecord::Migration[7.1]
  def change
    add_column :scenarios, :likes, :integer
    add_column :scenarios, :dislikes, :integer
    add_column :scenarios, :dont_cares, :integer
  end
end
