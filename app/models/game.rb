class Game < ApplicationRecord
  belongs_to :starting_layout, class_name: "House"
  belongs_to :goal_layout, class_name: "House"

  def self.build(player_count: 2)
    game = self.new
    game.starting_layout = House.generate(player_count: player_count)
    game.goal_layout = House.generate(player_count: player_count)
    game.save
    game
  end
end
