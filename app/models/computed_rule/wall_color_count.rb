module ComputedRule
  class WallColorCount < Requirement
    def self.random_feature
      "singular_rule"
    end

    def self.build(house:, feature:)
      rule = create

      rule.text = case house.wall_colors.uniq.count
                  when 4
                    "The walls of every room must be painted a different color"
                  when 3
                    "There must be exactly three different wall colors"
                  when 2
                    "There must be exactly two different wall colors"
                  else
                    "The walls of every room must be painted the same color"
                  end
      rule.save
      rule
    end
  end
end
