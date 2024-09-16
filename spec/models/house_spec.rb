require 'rails_helper'

RSpec.describe House, type: :model do
  describe ".generate" do
    it "creates a house" do
      house = described_class.generate
      expect(house).to be_a(described_class)
      expect(house.rooms).to all(be_a(Room)).and have_exactly(4).items
    end
  end
end
