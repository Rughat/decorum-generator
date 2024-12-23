module ComputedRule
  class ExactCountOfFurnishing < Requirement
    def self.random_feature
      Furnishing.random.to_s
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random
      furnishing = feature.constantize.new
      count = house.count_furnishings(furnishing: furnishing.short_name, section: section)
      rule = create
      rule.text = "The #{section.name} must contain exactly #{count} #{furnishing.short_name.pluralize(count)}#{furnishing.icon}".html_safe
      rule.save
      rule
    end
  end
end
