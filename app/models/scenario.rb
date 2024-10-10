class Scenario < ApplicationRecord
  has_many :players
  belongs_to :starting_layout, class_name: "House"
  belongs_to :goal_layout, class_name: "House"

  def self.build(player_count: "2")
    scenario = self.new
    scenario.starting_layout = House.generate(player_count: player_count)
    scenario.goal_layout = House.generate(player_count: player_count)
    player_count.to_i.times do
      scenario.players.append(Player.generate(goal: scenario.goal_layout))
    end
    scenario.save
    scenario
  end
end
