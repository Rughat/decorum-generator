module ComputedRule
  class ExactCountOfStyle < Requirement
    def self.random_feature
      Style.random
    end

    def self.build(house:, sections: Section, feature:)
      section = sections.random
      style = Style.new(feature)
      count = house.count_styles(style: feature, section: section)
      rule = create
      rule.text = "The #{section.name} must contain exactly #{count} #{style.display} #{"object".pluralize(count)}"
      rule.save
      rule
    end
  end
end
