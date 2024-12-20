module ComputedRule
  class ComparableCountOfColorVsStyle < Requirement
    def self.random_feature
      "#{Color.random_color}-#{Style.random}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      c, style = feature.split("-")
      color = Color.new(c)
      color_count = house.count_colors(color: color, section: section)
      style_count = house.count_styles(style: style, section: section)
      rule = create
      rule.text = if style_count == color_count
                    "The #{section.name} must contain an equal number of #{style} objects and #{color.display} features (as objects and/or wall colors)".html_safe
      else
        "The #{section.name} must contain #{(style_count < color_count) ? "fewer" : "more"} #{style} objects than #{color.display} features (as objects and/or wall colors)".html_safe
      end
      rule.save
      rule
    end
  end
end
