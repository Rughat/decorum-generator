module ComputedRule
  class RelativeCountOfColor < Requirement
    def self.build(house:, colors: Colors, sections: Section)
      color = colors.random
      section = sections.random_opposable
      count = house.count_colors(color: color, section: section)
      opposite_count = house.count_colors(color: color, section: section.opposite)
      rule = self.create
      rule.text = if count == opposite_count
                    "The #{section.name} and the #{section.opposite.name} must contain an equal amount of #{color} features (as objects and/or wall colors)"
      else
                    "The #{section.name} must contain #{count < opposite_count ? "less" : "more" } #{color} features than the #{section.opposite.name} (as objects and/or wall colors)"
      end
      rule.save
      rule
    end
  end
end
