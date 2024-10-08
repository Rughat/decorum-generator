class Requirement < ApplicationRecord
  belongs_to :player

  def self.generate(goal:, rule_source: ComputedRule)
    rule_source.all.sample.build(house: goal)
  end
end
