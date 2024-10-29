module ComputedRule
  class ExactCountOfColor < Requirement
    def self.random_feature
      Colors.random
    end

    def self.build(house:, colors: Colors, sections: Section, feature: colors.random)
      section = sections.random
      count = house.count_colors(color: feature, section: section)
      rule = create
      rule.text = "The #{section.name} must contain exactly #{count} #{feature} #{"feature".pluralize(count)} (as objects and/or wall colors)"
      rule.save
      rule
    end
  end
end
