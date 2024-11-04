class AddReqCountToScenario < ActiveRecord::Migration[7.1]
  def change
    add_column :scenarios, :requirement_count, :integer
  end
end
