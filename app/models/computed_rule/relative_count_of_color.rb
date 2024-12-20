module ComputedRule
  class RelativeCountOfColor < Requirement
    def self.random_feature
      Color.random_colorgroup.color
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_opposable
      color = Color.new(feature)
      count = house.count_colors(color: color, section: section)
      opposite_count = house.count_colors(color: color, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
                    "The #{section.name} must contain an equal amount of #{color.display} features (as objects and/or wall colors) as the #{section.opposite.name}".html_safe
      else
        "The #{section.name} must contain #{(count < opposite_count) ? "fewer" : "more"} #{color.display} features than the #{section.opposite.name} (as objects and/or wall colors)".html_safe
      end
      rule.save
      rule
    end
  end
end
