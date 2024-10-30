module ComputedRule
  class ExactCountOfFurnishing < Requirement
    def self.random_feature
      Furnishing.random.short_name
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random
      count = house.count_furnishings(furnishing: feature, section: section)
      rule = create
      rule.text = "The #{section.name} must contain exactly #{count} #{feature.pluralize(count)}"
      rule.save
      rule
    end
  end
end
