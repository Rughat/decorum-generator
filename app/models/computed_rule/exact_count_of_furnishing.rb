module ComputedRule
  class ExactCountOfFurnishing < Requirement
    def self.build(house:, furnishings: Furnishing, sections: Section, feature: furnishings.random.short_name)
      section = sections.random
      count = house.count_furnishings(furnishing: feature, section: section)
      rule = self.create
      rule.text = "The #{section.name} must contain exactly #{count} #{feature.pluralize(count)}"
      rule.save
      rule
    end
  end
end
