module ComputedRule
  class RelativeCountOfStyle < Requirement
    def self.random_feature
      Style.random
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_opposable
      style = Style.new(feature)
      count = house.count_styles(style: feature, section: section)
      opposite_count = house.count_styles(style: feature, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
        "The #{section.display} must contain an equal amount of #{style.display} objects as the #{section.opposite.display}"
      else
        "The #{section.display} must contain #{(count < opposite_count) ? "fewer" : "more"} #{style.display} objects than the #{section.opposite.display}"
      end
      rule.save
      rule
    end
  end
end
