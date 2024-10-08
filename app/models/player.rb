class Player < ApplicationRecord
  belongs_to :game
  has_many :requirements

  def self.generate(goal:)
    player = Player.create
    4.times do
      player.requirements.append(Requirement.generate(goal: goal))
    end
    player
  end
end
