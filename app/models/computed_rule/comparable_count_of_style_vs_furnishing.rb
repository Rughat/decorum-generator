module ComputedRule
  class ComparableCountOfStyleVsFurnishing < Requirement
    def self.random_feature
      "#{Style.random}-#{Furnishing.random.short_name}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      style, furnishing = feature.split("-")
      style_count = house.count_styles(style: style, section: section)
      furnishing_count = house.count_furnishings(furnishing: furnishing, section: section)
      rule = create
      rule.text = if furnishing_count == style_count
                    "The #{section.name} must contain an equal number of #{furnishing.pluralize} and #{style} features"
      else
        "The #{section.name} must contain #{(furnishing_count < style_count) ? "fewer" : "more"} #{furnishing.pluralize} than #{style} features"
      end
      rule.save
      rule
    end
  end
end
