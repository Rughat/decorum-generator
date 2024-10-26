class RequirementGenerator
  attr_accessor :requirement_list, :requirement_count

  def initialize(players:, requirement_count:, rule_source: ComputedRule)
    self.requirement_list = []
    self.requirement_count = requirement_count
    (requirement_count * players).times do
      proposed_rule = rule_source.all.sample
      self.requirement_list << PrototypeRequirement.new(rule: proposed_rule, feature: proposed_rule.random_feature)
    end
  end

  def generate_requirements(player:, goal:)
    requirement_count.times do
      req_template = requirement_list.pop
      player.requirements.append(req_template.rule.build(house: goal))
    end
  end
end
