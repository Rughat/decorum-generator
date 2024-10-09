module ComputedRule
  class RelativeCountOfFurnishing < Requirement
    def self.build(house:, furnishings: Furnishing, sections: Section)
      furnishing = furnishings.random
      section = sections.random_multiroom_opposable
      count = house.count_furnishings(furnishing: furnishing, section: section)
      opposite_count = house.count_furnishings(furnishing: furnishing, section: section.opposite)
      rule = self.create
      rule.text = if count == opposite_count
                    "The #{section.name} and the #{section.opposite.name} must contain an equal amount of #{furnishing.short_name.pluralize}"
      else
        "The #{section.name} must contain #{count < opposite_count ? "less" : "more" } #{furnishing.short_name.pluralize} than the #{section.opposite.name}"
      end
      rule.save
      rule
    end
  end
end
