module ComputedRule
  class ExactCountOfStyle < Requirement
    def self.build(house:, styles: Style, sections: Section, feature: styles.random)
      section = sections.random
      count = house.count_styles(style: feature, section: section)
      rule = self.create
      rule.text = "The #{section.name} must contain exactly #{count} #{feature} #{"object".pluralize(count)}"
      rule.save
      rule
    end
  end
end
