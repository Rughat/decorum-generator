require 'rails_helper'

RSpec.describe Scenario, type: :model do
  describe ".initialize" do
    it "creates a new scenario with required elements" do
      scenario = described_class.build
      expect(scenario.valid?).to be_truthy
      expect(scenario.starting_layout).to be_a(House)
      expect(scenario.goal_layout).to be_a(House)
      expect(scenario.players).to all(be_a(Player)).and have_exactly(2).items
      expect(scenario.players.first.requirements).to all(be_a(Requirement)).and have_at_least(3).items
      expect(scenario.players.last.requirements).to all(be_a(Requirement)).and have_at_least(3).items
    end
  end
end
