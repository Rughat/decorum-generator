module ComputedRule
  class RelativeCountOfFurnishing < Requirement
    def self.random_feature
      Furnishing.random.short_name
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom_opposable
      count = house.count_furnishings(furnishing: feature, section: section)
      opposite_count = house.count_furnishings(furnishing: feature, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
        "The #{section.name} must contain an equal amount of #{feature.pluralize} as the #{section.opposite.name}"
      else
        "The #{section.name} must contain #{(count < opposite_count) ? "fewer" : "more"} #{feature.pluralize} than the #{section.opposite.name}"
      end
      rule.save
      rule
    end
  end
end
