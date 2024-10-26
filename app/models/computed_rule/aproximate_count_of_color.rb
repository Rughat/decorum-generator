module ComputedRule
  class AproximateCountOfColor < Requirement
    def self.random_feature
      Colors.random
    end

    def self.build(house:, colors: Colors, sections: Section)
      color = colors.random
      section = sections.random
      count = house.count_colors(color: color, section: section)
      rule = self.create
      rule.text = "The #{section.name} must contain exactly #{count} #{color} #{"feature".pluralize(count)} (as objects and/or wall colors)"
      rule.save
      rule
    end
  end
end
