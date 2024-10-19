class RequirementGenerator
  class SpecificRequirement
    attr_accessor :rule, :feature

    def initialize(rule:, feature:)
      self.rule = rule
      self.feature = feature
    end
  end

  attr_accessor :requirement_list, :requirement_count

  def initialize(players:, requirement_count:, rule_source: ComputedRule)
    self.requirement_list = []
    self.requirement_count = requirement_count
    (requirement_count * players).times do
      self.requirement_list << SpecificRequirement.new(rule: rule_source.all.sample, feature: :test)
    end
  end

  def generate_requirements(player:, goal:)
    requirement_count.times do
      req_template = requirement_list.pop
      player.requirements.append(req_template.rule.build(house: goal))
    end
  end

end
