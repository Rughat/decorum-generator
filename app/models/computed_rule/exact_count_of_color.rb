module ComputedRule
  class ExactCountOfColor < Requirement
    def self.random_feature
      Color.random_colorgroup.color
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random
      color = Color.new(feature)
      count = house.count_colors(color: color, section: section)
      rule = create
      rule.text = "The #{section.display} must contain exactly #{count} #{color.display} #{"feature".pluralize(count)} (as objects and/or wall colors)"
      rule.save
      rule
    end
  end
end
