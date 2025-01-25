module ComputedRule
  class ExactSingleFurnishing < Requirement
    def self.random_feature
      Section.random_single.index
    end

    def self.build(house:, furnishings: Furnishing, feature:)
      section = Section.new(feature.to_i)
      furnishing_class = furnishings.random_real
      furnishing = house.get_room(section.rooms.first).get_furnishing(furnishing_class)
      rule = create
      rule.text = (furnishing.empty?) ? "The #{section.display} must not contain a #{furnishing_class.short_name}#{furnishing.icon}" : "The #{section.display} must contain #{furnishing.long_description.downcase}"
      rule.save
      rule
    end
  end
end
