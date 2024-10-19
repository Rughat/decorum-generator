require 'rails_helper'

RSpec.describe RequirementGenerator do
  let(:subject) { described_class.new(players: 4, requirement_count: 4) }
  describe "#initialize" do
    it "accepts a count of players and # of requirements per player" do
      expect(subject).to be_instance_of(described_class)
      expect(subject.requirement_count).to eq(4)
    end

    it "creates a list of unique requirement and feature combos" do
      expect(subject.requirement_list.count).to eq(16)
      expect(subject.requirement_list.map(&:feature)).to all(be_a(Symbol))
      expect(subject.requirement_list.map(&:rule).map(&:ancestors)).to all(include(Requirement))
    end
  end

  describe "#generate_requirements" do
    let(:player) { instance_double(Player) }
    let(:goal) { instance_double(House) }
    let(:rule_source) { class_double(ComputedRule) }
    let(:rule_source_collection) { [computed_rule] }
    let(:computed_rule) { instance_double(ComputedRule) }
    let(:finished_rule) { instance_double(Rule) }
    let(:player_reqs) { [] }

    it "generates requirements for that player from the unique requirements list" do
      allow(rule_source).to receive(:all).exactly(16).times.and_return(rule_source_collection)
      subject = described_class.new(players: 4, requirement_count: 4, rule_source: rule_source)
      expect(computed_rule).to receive(:build).with(house: goal).exactly(4).times.and_return(finished_rule)
      expect(player).to receive(:requirements).exactly(4).times.and_return(player_reqs)
      subject.generate_requirements(player: player, goal: goal)
      expect(player_reqs.count).to eq(4)
      expect(player_reqs).to all(be(finished_rule))
    end
  end
end
