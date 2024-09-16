require 'rails_helper'

RSpec.describe Game, type: :model do
  describe ".initialize" do
    it "creates a new game with required elements" do
      game = described_class.build
      expect(game.valid?).to be_truthy
      expect(game.starting_layout).to be_a(House)
      expect(game.goal_layout).to be_a(House)
      expect(game.requirements).to be_a(Array).and have_exactly(2).items
      expect(game.requirements[0]).to all(be_a(Requirement)).and have_at_least(3).items
    end
  end
end
