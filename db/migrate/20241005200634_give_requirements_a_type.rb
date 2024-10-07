class GiveRequirementsAType < ActiveRecord::Migration[7.1]
  def change
    add_column :requirements, :type, :string
    add_column :requirements, :text, :string
  end
end
