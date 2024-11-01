module ComputedRule
  class RelativeCountOfStyle < Requirement
    def self.random_feature
      Style.random
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_opposable
      count = house.count_styles(style: feature, section: section)
      opposite_count = house.count_styles(style: feature, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
        "The #{section.name} must contain an equal amount of #{feature} objects as the #{section.opposite.name}"
      else
        "The #{section.name} must contain #{(count < opposite_count) ? "less" : "more"} #{feature} objects than the #{section.opposite.name}"
      end
      rule.save
      rule
    end
  end
end
