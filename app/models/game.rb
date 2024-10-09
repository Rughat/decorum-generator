class Game < ApplicationRecord
  has_many :players
  belongs_to :starting_layout, class_name: "House"
  belongs_to :goal_layout, class_name: "House"

  def self.build(player_count: "2")
    game = self.new
    game.starting_layout = House.generate(player_count: player_count)
    game.goal_layout = House.generate(player_count: player_count)
    player_count.to_i.times do
      game.players.append(Player.generate(goal: game.goal_layout))
    end
#    game.players.append(Player.generate(goal: game.goal_layout))
#    game.players.append(Player.generate(goal: game.goal_layout))
    game.save
    game
  end
end
