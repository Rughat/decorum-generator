require "rails_helper"

RSpec.describe ComputedRule::WallColorCount do
  describe ".random_feature" do
    it "calls and returns a singular rule" do
      expect(described_class.random_feature.to_s).to eq("singular_rule")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }

    context "when the house has all four wall colors" do
      it "builds the rule requiring that there be all four colors in the house" do
        expect(house).to receive(:wall_colors).and_return(["red", "blue", "green", "yellow"])
        subject = described_class.build(house: house, feature: "singular_rule")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The walls of every room must be painted a different color")
      end
    end

    context "when the house has three wall colors" do
      it "builds the rule requiring that there be three wall colors in the house" do
        expect(house).to receive(:wall_colors).and_return(["red", "blue", "green", "green"])
        subject = described_class.build(house: house, feature: "singular_rule")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("There must be exactly three different wall colors")
      end
    end

    context "when the house has two different wall colors" do
      it "builds the rule requiring that there be two wall colors in the house" do
        expect(house).to receive(:wall_colors).and_return(["red", "yellow", "yellow", "yellow"])
        subject = described_class.build(house: house, feature: "singular_rule")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("There must be exactly two different wall colors")
      end
    end

    context "when the house has only one wall color" do
      it "builds the rule requiring that there be only one wall color in the house" do
        expect(house).to receive(:wall_colors).and_return(["red", "red", "red", "red"])
        subject = described_class.build(house: house, feature: "singular_rule")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The walls of every room must be painted the same color")
      end
    end
  end
end
