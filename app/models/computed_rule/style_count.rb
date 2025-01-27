module ComputedRule
  class StyleCount < Requirement
    def self.random_feature
      Section.random_single.index
    end

    def self.build(house:, feature:)
      section = Section.new(feature.to_i)
      room = house.get_room(section.rooms.first)
      count = room.count_different_styles
      rule = create
      rule.text = case count
                  when 3
                    "The #{section.display} must have exactly three different styles of objects"
                  when 2
                    "The #{section.display} must have exactly two different styles of objects"
                  else
                    "The #{section.display} must have all objects the same style"
                  end
      rule.save
      rule
    end
  end
end
