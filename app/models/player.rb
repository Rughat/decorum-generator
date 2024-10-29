class Player < ApplicationRecord
  belongs_to :scenario
  has_many :requirements

  def self.generate
    Player.create
    #    4.times do
    #      player.requirements.append(Requirement.generate(goal: goal))
    #    end
  end
end
