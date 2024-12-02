module ComputedRule
  class AspectMustBeMostFrequent < Requirement
    def self.random_feature
      Furnishing.random_aspect
    end

    def self.build(house:, feature:)
      rule = create
      majority_aspect = house.get_majority(feature)
      addendum = (feature == "color") ? " (as objects and/or wall color)" : ""
      rule.text = "No other #{feature} in the house may appear more frequently than #{majority_aspect}#{addendum}"
      rule.save
      rule
    end
  end
end
