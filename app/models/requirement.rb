class Requirement < ApplicationRecord
  belongs_to :player

  def self.generate(goal:, rule_source: ComputedRule)
    rule_source.all.sample.build(house: goal)
  end

  def self.generate_group(rule_count:, rule_source: ComputedRule, goal:)
    Array.new(rule_count).map {|_| self.generate(goal: goal, rule_source: rule_source) }
  end
end
