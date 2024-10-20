class Scenario < ApplicationRecord
  has_many :players
  belongs_to :starting_layout, class_name: "House"
  belongs_to :goal_layout, class_name: "House"

  def self.build(player_count: "2", requirement_count: "4")
    scenario = self.new
    req_count = requirement_count.to_i
    player_cnt = player_count.to_i
    scenario.starting_layout = House.generate(player_count: player_count)
    scenario.goal_layout = House.generate(player_count: player_count)
    requirements = Requirement.generate_group(rule_count: req_count * 4, goal: scenario.goal_layout)
    requirement_generator = RequirementGenerator.new(players: player_cnt, requirement_count: req_count)
    player_count.to_i.times do
      player = Player.generate()
      requirement_generator.generate_requirements(player: player, goal: scenario.goal_layout)
      scenario.players.append(player)
    end
    scenario.save
    scenario
  end
end
