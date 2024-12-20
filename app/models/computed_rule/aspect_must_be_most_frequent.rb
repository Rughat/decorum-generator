module ComputedRule
  class AspectMustBeMostFrequent < Requirement
    def self.random_feature
      Furnishing.random_aspect
    end

    def self.build(house:, feature:)
      rule = create
      majority_aspect = house.get_majority(feature)
      addendum = (feature == "color") ? " (as objects and/or wall color)" : ""
      case feature
      when "color"
        majority_aspect = Color.new(majority_aspect).display
      when "furnishing"
        majority_aspect = majority_aspect.pluralize
      end
      rule.text = "No other #{feature} in the house may appear more frequently than #{majority_aspect}#{addendum}".html_safe
      rule.save
      rule
    end
  end
end
