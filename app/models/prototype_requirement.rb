class PrototypeRequirement
  attr_accessor :rule, :feature

  def initialize(rule:, feature:)
    self.rule = rule
    self.feature = feature
  end

  def build(goal:)
    rule.build(house: goal, feature: feature)
  end
end
