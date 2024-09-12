class House < ApplicationRecord
  has_one :game

  def self.generate(player_count: 2)
    self.create
  end
end
