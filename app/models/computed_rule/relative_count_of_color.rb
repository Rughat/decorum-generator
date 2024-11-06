module ComputedRule
  class RelativeCountOfColor < Requirement
    def self.random_feature
      Color.random_colorgroup
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_opposable
      count = house.count_colors(color: feature, section: section)
      opposite_count = house.count_colors(color: feature, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
        "The #{section.name} must contain an equal amount of #{feature} features (as objects and/or wall colors) as the #{section.opposite.name}"
      else
        "The #{section.name} must contain #{(count < opposite_count) ? "less" : "more"} #{feature} features than the #{section.opposite.name} (as objects and/or wall colors)"
      end
      rule.save
      rule
    end
  end
end
