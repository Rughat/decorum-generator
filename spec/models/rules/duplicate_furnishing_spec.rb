require "rails_helper"

RSpec.describe ComputedRule::DuplicateFurnishing do
  describe ".random_feature" do
    it "always returns a singlular_rule" do
      expect(described_class.random_feature).to eq("singular_rule")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }

    it "builds the rule with the count of duplicate features when there are multiple" do
      expect(house).to receive(:count_duplicate_furnishing).and_return(2)
      subject = described_class.build(house: house, feature: nil)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The house must contain exactly 2 duplicate objects")
    end

    it "builds the rule with the count of duplicate features when there is only one" do
      expect(house).to receive(:count_duplicate_furnishing).and_return(1)
      subject = described_class.build(house: house, feature: nil)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The house must contain exactly 1 duplicate object")
    end

    it "builds the rule with the count of duplicate features when there are none" do
      expect(house).to receive(:count_duplicate_furnishing).and_return(0)
      subject = described_class.build(house: house, feature: nil)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The house must contain no duplicate objects")
    end
  end
end
