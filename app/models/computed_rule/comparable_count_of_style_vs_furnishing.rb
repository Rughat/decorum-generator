module ComputedRule
  class ComparableCountOfStyleVsFurnishing < Requirement
    def self.random_feature
      "#{Style.random}-#{Furnishing.random.to_s}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      s, furnishing_raw = feature.split("-")
      furnishing = furnishing_raw.constantize.new
      style = Style.new(s)
      style_count = house.count_styles(style: style.to_s, section: section)
      furnishing_count = house.count_furnishings(furnishing: furnishing.short_name, section: section)
      rule = create
      rule.text = if furnishing_count == style_count
        "The #{section.name} must contain an equal number of #{furnishing.short_name.pluralize}#{furnishing.icon} and #{style.display} features"
      else
        "The #{section.name} must contain #{(furnishing_count < style_count) ? "fewer" : "more"} #{furnishing.short_name.pluralize}#{furnishing.icon} than #{style.display} features"
      end
      rule.save
      rule
    end
  end
end
