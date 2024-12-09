module ComputedRule
  class ComparableCountOfColorVsFurnishing < Requirement
    def self.random_feature
      "#{Color.random_color}-#{Furnishing.random.short_name}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      c, furnishing = feature.split("-")
      color = Color.new(c)
      color_count = house.count_colors(color: color, section: section)
      furnishing_count = house.count_furnishings(furnishing: furnishing, section: section)
      rule = create
      rule.text = if furnishing_count == color_count
                    "The #{section.name} must contain an equal number of #{furnishing.pluralize} and #{color} features (as objects and/or wall colors)"
      else
        "The #{section.name} must contain #{(furnishing_count < color_count) ? "less" : "more"} #{furnishing.pluralize} than #{color} features (as objects and/or wall colors)"
      end
      rule.save
      rule
    end
  end
end
