require 'rails_helper'

RSpec.describe ComputedRule, type: :model do
  describe "#all" do
    it "gets the expect list of classes" do
      expect(described_class.all).to include(ComputedRule::ExactCountOfStyle)
    end
  end
end

