module ComputedRule
  class AspectMustBeMostFrequent < Requirement
    def self.random_feature
      Furnishing.random_aspect
    end

    def self.build(house:, feature:)
      rule = create
      majority_aspect = house.get_majority(feature)
      case feature
      when "style"
        majority_aspect = Style.new(majority_aspect).display
        addendum = ""
      when "color"
        majority_aspect = Color.new(majority_aspect).display
        addendum = " (as objects and/or wall color)"
      when "furnishing"
        furnishing = majority_aspect.constantize.new
        majority_aspect = furnishing.short_name.pluralize
        addendum = furnishing.icon
      end
      rule.text = "No other #{feature} in the house may appear more frequently than #{majority_aspect}#{addendum}".html_safe
      rule.save
      rule
    end
  end
end
