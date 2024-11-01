class RequirementGenerator
  attr_accessor :requirement_list, :requirement_count

  def initialize(players:, requirement_count:, rule_source: ComputedRule)
    self.requirement_list = []
    self.requirement_count = requirement_count
    while requirement_list.count < (requirement_count * players)
      proposed_rule = rule_source.all.sample
      proposed_feature = proposed_rule.random_feature
      if requirement_list.none? { |pr| pr.rule == proposed_rule && pr.feature.to_s == proposed_feature.to_s }
        requirement_list << PrototypeRequirement.new(rule: proposed_rule, feature: proposed_feature)
      end
    end
  end

  def generate_requirements(player:, goal:)
    requirement_count.times do
      req_template = requirement_list.pop
      player.requirements.append(req_template.rule.build(house: goal, feature: req_template.feature))
    end
  end
end
