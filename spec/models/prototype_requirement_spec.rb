require 'rails_helper'

RSpec.describe PrototypeRequirement do
  let(:rule) { ComputedRule::ExactCountOfColor }
  let(:feature) { "red" }
  let(:subject) { described_class.new(rule: rule, feature: feature) }
  let(:goal) { instance_double(House) }

  describe "#initialize" do
    it "stores a requirement with a feature when instantiated" do
      expect(subject.feature).to eq(feature)
      expect(subject.rule).to eq(rule)
    end
  end

  describe "#build" do
    let(:computed_rule) { instance_double(rule) }
    it "when passed a goal house, it builds a completed requirment with the stored feature" do
      expect(rule).to receive(:build).with(house: goal, feature: feature).and_return(computed_rule)
      expect(subject.build(goal: goal)).to eq(computed_rule)
    end
  end
end
