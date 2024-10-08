module ComputedRule
  class RelativeCountOfStyle < Requirement
    def self.build(house:, styles: Style, sections: Section)
      style = styles.random
      section = sections.random_opposable
      count = house.count_styles(style: style, section: section)
      opposite_count = house.count_styles(style: style, section: section.opposite)
      rule = self.create
      rule.text = if count == opposite_count
                    "The #{section.name} and the #{section.opposite.name} must contain an equal amount of #{style} objects"
      else
                    "The #{section.name} must contain #{count < opposite_count ? "less" : "more" } #{style} objects than the #{section.opposite.name}"
      end
      rule.save
      rule
    end
  end
end
