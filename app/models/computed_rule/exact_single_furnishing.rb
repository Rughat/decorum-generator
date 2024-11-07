module ComputedRule
  class ExactSingleFurnishing < Requirement
    def self.random_feature
      Section.random_single
    end

    def self.build(house:, furnishings: Furnishing, feature:)
      # select a random type of feature (lamp/curio/wallhanging)
      # find furnishing in feature, if it exists
      # if exists, expect furnishing in feature
      # otherwise, expect furnishing to not exist in feature
      furnishing_class = furnishings.random_real
      furnishing = house.get_room(feature.rooms.first).get_furnishing(furnishing_class)
      rule = create
      rule.text = (furnishing.class == EmptyFurnishing) ? "The #{feature.name} must not contain a #{furnishing_class.short_name}" : "The #{feature.name} must contain #{furnishing.long_description.downcase}"
      rule.save
      rule
    end
  end
end
