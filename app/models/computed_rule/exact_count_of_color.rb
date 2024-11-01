module ComputedRule
  class ExactCountOfColor < Requirement
    def self.random_feature
      Color.random_color
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random
      count = house.count_colors(color: feature, section: section)
      rule = create
      rule.text = "The #{section.name} must contain exactly #{count} #{feature.to_s} #{"feature".pluralize(count)} (as objects and/or wall colors)"
      rule.save
      rule
    end
  end
end
