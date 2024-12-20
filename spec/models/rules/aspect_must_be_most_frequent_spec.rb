require "rails_helper"

RSpec.describe ComputedRule::AspectMustBeMostFrequent do
  describe ".random_feature" do
    it "calls and returns a random aspect type" do
      expect(Furnishing).to receive(:random_aspect).and_return("color")
      expect(described_class.random_feature).to eq("color")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }

    context "when using the color aspect" do
      it "builds the rule requiring that the majority color is required to be greater than any other in the house" do
        expect(house).to receive(:get_majority).with("color").and_return("blue")
        subject = described_class.build(house: house, feature: "color")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("No other color in the house may appear more frequently than <span class=\"blue\">blue<\/span> (as objects and/or wall color)")
      end
    end

    context "when using the style aspect" do
      it "builds the rule requiring that the majority style is required to be greater than any other in the house" do
        expect(house).to receive(:get_majority).with("style").and_return("modern")
        subject = described_class.build(house: house, feature: "style")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("No other style in the house may appear more frequently than modern")
      end
    end

    context "when using the furnishing aspect" do
      it "builds the rule requiring that the majority furnishing is required to be greater than any other in the house" do
        expect(house).to receive(:get_majority).with("furnishing").and_return("lamp")
        subject = described_class.build(house: house, feature: "furnishing")
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("No other furnishing in the house may appear more frequently than lamps")
      end
    end
  end
end
