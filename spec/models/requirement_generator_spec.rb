require 'rails_helper'

RSpec.describe RequirementGenerator do
  describe "#initialize" do
    let(:subject) { described_class.new(players: 4, requirement_count: 4) }
    it "accepts a count of players and # of requirements per player" do
      expect(subject).to be_instance_of(described_class)
    end

    it "creates a list of unique requirement and feature combos" do
      expect(subject.requirement_list.count).to eq(16)
      expect(subject.requirement_list).to all(have_attributes(:rule => be_a_kind_of(ComputedRule), :feature => be_a_symbol))
    end
  end

  describe "#generate_requirements" do
    it "accepts a player"

    it "generates requirements for that player from the unique requirements list"
  end
end
