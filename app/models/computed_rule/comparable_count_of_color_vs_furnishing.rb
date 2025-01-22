module ComputedRule
  class ComparableCountOfColorVsFurnishing < Requirement
    def self.random_feature
      "#{Color.random_color}-#{Furnishing.random.to_s}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      c, furnishing_raw = feature.split("-")
      furnishing = furnishing_raw.constantize.new
      color = Color.new(c)
      color_count = house.count_colors(color: color, section: section)
      furnishing_count = house.count_furnishings(furnishing: furnishing.short_name, section: section)
      rule = create
      rule.text = if furnishing_count == color_count
                    "The #{section.display} must contain an equal number of #{furnishing.short_name.pluralize}#{furnishing.icon} and #{color.display} features (as objects and/or wall colors)".html_safe
      else
        "The #{section.display} must contain #{(furnishing_count < color_count) ? "fewer" : "more"} #{furnishing.short_name.pluralize}#{furnishing.icon} than #{color.display} features (as objects and/or wall colors)".html_safe
      end
      rule.save
      rule
    end
  end
end
