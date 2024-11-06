module ComputedRule
  class StyleCount < Requirement
    def self.random_feature
      Section.random_single.rooms.first
    end

    def self.build(house:, feature:)
      room = house.get_room(feature)
      count = room.count_different_styles
      rule = create
      rule.text = case count
                  when 3
                    "The #{room.lower_name} must have exactly three different styles of objects"
                  when 2
                    "The #{room.lower_name} must have exactly two different styles of objects"
                  else
                    "The #{room.lower_name} must have all objects the same style"
                  end
      rule.save
      rule
    end
  end
end
