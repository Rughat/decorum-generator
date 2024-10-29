require 'rails_helper'

RSpec.describe RequirementGenerator do
  describe "#initialize" do
    let(:subject) { described_class.new(players: 4, requirement_count: 4) }
    it "accepts a count of players and # of requirements per player" do
      expect(subject).to be_instance_of(described_class)
      expect(subject.requirement_count).to eq(4)
    end

    it "creates a list of unique requirement and feature combos" do
      expect(subject.requirement_list.count).to eq(16)
      expect(subject.requirement_list.map(&:feature)).to all(be_a(String))
      expect(subject.requirement_list.map(&:rule).map(&:ancestors)).to all(include(Requirement))
    end
  end

  describe "#generate_requirements" do
    let(:first_player) { instance_double(Player) }
    let(:second_player) { instance_double(Player) }
    let(:goal) { instance_double(House) }
    let(:rule_source) { class_double(ComputedRule) }

    let(:first_rule) { class_double(ComputedRule::ExactCountOfColor) }
    let(:second_rule) { class_double(ComputedRule::ExactCountOfFurnishing) }
    let(:third_rule) { class_double(ComputedRule::RelativeCountOfStyle) }
    let(:first_finished_rule) { instance_double(Rule) }
    let(:second_finished_rule) { instance_double(Rule) }
    let(:third_finished_rule) { instance_double(Rule) }
    let(:fourth_finished_rule) { instance_double(Rule) }

    let(:order_of_rule_results) {
      [
         OpenStruct.new( rule: first_rule,
                       feature: "red",
                       result: first_finished_rule ),
         OpenStruct.new( rule: first_rule,
                        feature: "red",
                        result: nil ),
         OpenStruct.new( rule: first_rule,
                        feature: "blue",
                        result: second_finished_rule ),
         OpenStruct.new( rule: second_rule,
                        feature: "empty space",
                        result: third_finished_rule ),
         OpenStruct.new( rule: first_rule,
                        feature: "blue",
                        result: nil ),
         OpenStruct.new( rule: second_rule,
                        feature: "empty space",
                        result: nil ),
         OpenStruct.new( rule: third_rule,
                        feature: "modern",
                        result: fourth_finished_rule )
      ] }

    let(:uniq_rules) { order_of_rule_results.map(&:rule).uniq }
    let(:valid_rules) { order_of_rule_results.select { |call| call.result } }

    let(:random_sample_arrays) { order_of_rule_results.map { |call| [call.rule] } }

    let(:first_player_reqs) { [] }
    let(:second_player_reqs) { [] }

    it "generates requirements for that player from the unique requirements list" do

      expect(rule_source).to receive(:all).exactly(7).times.and_return(*random_sample_arrays)

      uniq_rules.each do |rule|
        attempts_to_use_rule = order_of_rule_results.select { |call| call.rule == rule}

        expect(rule).to receive(:random_feature).exactly(attempts_to_use_rule.count).times.and_return(*attempts_to_use_rule.map(&:feature))
      end

      subject = described_class.new(players: 2, requirement_count: 2, rule_source: rule_source)

      expect(subject.requirement_list.count).to eq(4)

      valid_rules.last(2).each do |call|
        expect(call.rule).to receive(:build).with(house: goal, feature: call.feature).and_return(call.result)
      end
      expect(first_player).to receive(:requirements).exactly(2).times.and_return(first_player_reqs)
      subject.generate_requirements(player: first_player, goal: goal)
      expect(first_player_reqs.count).to eq(2)
      expect(first_player_reqs).to contain_exactly(third_finished_rule, fourth_finished_rule)

      valid_rules.first(2).each do |call|
        expect(call.rule).to receive(:build).with(house: goal, feature: call.feature).and_return(call.result)
      end
      expect(second_player).to receive(:requirements).exactly(2).times.and_return(second_player_reqs)
      subject.generate_requirements(player: second_player, goal: goal)
      expect(second_player_reqs.count).to eq(2)
      expect(second_player_reqs).to contain_exactly(first_finished_rule, second_finished_rule)
    end
  end
end
