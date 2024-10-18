class RequirementGenerator
  class SpecificRequirement
    attr_accessor :rule, :feature

    def initialize(rule:, feature:)
      self.rule = rule
      self.feature = feature
    end
  end

  attr_accessor :requirement_list

  def initialize(players:, requirement_count:)
    self.requirement_list = []
    (requirement_count * players).times do
      self.requirement_list << SpecificRequirement.new(rule: :test, feature: Requirement.new)
    end
  end

end
