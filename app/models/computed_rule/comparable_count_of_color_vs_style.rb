module ComputedRule
  class ComparableCountOfColorVsStyle < Requirement
    def self.random_feature
      "#{Color.random_color}-#{Style.random}"
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random_multiroom
      c, s = feature.split("-")
      color = Color.new(c)
      style = Style.new(s)
      color_count = house.count_colors(color: color, section: section)
      style_count = house.count_styles(style: style.to_s, section: section)
      rule = create
      rule.text = if style_count == color_count
        "The #{section.display} must contain an equal number of #{style.display} objects and #{color.display} features (as objects and/or wall colors)".html_safe
      else
        "The #{section.display} must contain #{(style_count < color_count) ? "fewer" : "more"} #{style.display} objects than #{color.display} features (as objects and/or wall colors)".html_safe
      end
      rule.save
      rule
    end
  end
end
