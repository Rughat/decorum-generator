module ComputedRule
  class ExactCountOfFurnishing < Requirement
    def self.build(house:, furnishings: Furnishing, sections: Section)
      furnishing = furnishings.random
      section = sections.random
      count = house.count_furnishings(furnishing: furnishing, section: section)
      rule = self.create
      rule.text = "The #{section.name} must contain exactly #{count} #{furnishing.short_name.pluralize(count)}"
      rule.save
      rule
    end
  end
end
