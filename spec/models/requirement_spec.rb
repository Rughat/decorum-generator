require 'rails_helper'

RSpec.describe Requirement do
  let(:rule_source) { class_double(ComputedRule) }
  let(:rule_source_collection) { [computed_rule] }
  let(:computed_rule) { instance_double(ComputedRule) }
  let(:house) { instance_double(House) }
  let(:finished_rule) { instance_double(Rule) }

  it "generates a requirement that matches the given house" do
    expect(rule_source).to receive(:all).and_return(rule_source_collection)
    expect(computed_rule).to receive(:build).with(house: house).and_return(finished_rule)
    expect(Requirement.generate(goal: house, rule_source: rule_source)).to eq(finished_rule)
  end
end
