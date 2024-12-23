module ComputedRule
  class RelativeCountOfFurnishing < Requirement
    def self.random_feature
      Furnishing.random.to_s
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom_opposable
      furnishing = feature.constantize.new
      count = house.count_furnishings(furnishing: furnishing.short_name, section: section)
      opposite_count = house.count_furnishings(furnishing: furnishing.short_name, section: section.opposite)
      rule = create
      rule.text = if count == opposite_count
        "The #{section.name} must contain an equal amount of #{furnishing.short_name.pluralize}#{furnishing.icon} as the #{section.opposite.name}".html_safe
      else
        "The #{section.name} must contain #{(count < opposite_count) ? "fewer" : "more"} #{furnishing.short_name.pluralize}#{furnishing.icon} than the #{section.opposite.name}".html_safe
      end
      rule.save
      rule
    end
  end
end
