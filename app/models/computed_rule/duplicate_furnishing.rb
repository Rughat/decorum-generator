module ComputedRule
  class DuplicateFurnishing < Requirement
    def self.random_feature
      nil
    end

    def self.build(house:, feature:)
      count = house.count_duplicate_furnishing
      rule = create
      rule.text = (count > 0) ? "The house must contain exactly #{count} duplicate #{"object".pluralize(count)}" : "The house must contain no duplicate objects"
      rule.save
      rule
    end
  end
end
