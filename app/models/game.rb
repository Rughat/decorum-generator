class Game < ApplicationRecord
  belongs_to :starting_layout, class_name: "House"
  belongs_to :goal_layout, class_name: "House"

  self.primary_key = :id

end
