module ComputedRule
  class TotalColorsInRoom < Requirement
    def self.random_feature
      "singular_rule"
    end

    def self.build(house:, sections: Section, feature:)
      rooms = sections.all_rooms
      max_colors = rooms.map { |room| house.get_distinct_colors(section: room).count }.max

      rule = create

      rule.text = case max_colors
                  when 4
                    "There must be at least one room in the house with all four colors (as objects and/or wall color)"
                  when 3
                    "There may not be any room with all four colors in the house (as objects and/or wall color)"
                  when 2
                    "There may not be more than two different colors in any room (as objects and/or wall color)"
                  else
                    "Every feature and object in a room must be the same color"
                  end
      rule.save
      rule
    end
  end
end
