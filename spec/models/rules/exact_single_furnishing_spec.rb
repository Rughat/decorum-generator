require "rails_helper"

RSpec.describe ComputedRule::ExactSingleFurnishing do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Section).to receive(:random_single).and_return(Section.new(7))
      expect(described_class.random_feature).to eq(7)
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:furnishings) { class_double(Furnishing) }
    let(:room) { instance_double(Room) }
    let(:specific_type) { Lamp }
    let(:specific_furnishing) { Lamp.new(color: Color.new("red")) }
    let(:feature_index) { 7 }
    let(:feature) { Section.new(7) }

    context "when the feature exists in the room" do
      let(:specific_furnishing) { Lamp.new(color: Color.new("red")) }

      it "randomly builds a rule from the given house with a given feature" do
        expect(furnishings).to receive(:random_real).and_return(specific_type)
        expect(house).to receive(:get_room).with("bathroom").and_return(room)
        expect(room).to receive(:get_furnishing).with(specific_type).and_return(specific_furnishing)
        expect(Section).to receive(:new).with(feature_index).and_return(feature)
        subject = described_class.build(house: house, feature: feature_index, furnishings: furnishings)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The bathroom<span class=\"icon-bathroom\"><\/span> must contain a <span class=\"red\">red<\/span> retro<span class=\"icon-retro\"><\/span> lamp<span class=\"icon-lamp\"><\/span>")
      end
    end

    context "when the feature does not exist in the room" do
      let(:specific_furnishing) { EmptyLamp.new }

      it "randomly builds a rule from the given house with a given feature" do
        expect(furnishings).to receive(:random_real).and_return(specific_type)
        expect(house).to receive(:get_room).with("bathroom").and_return(room)
        expect(room).to receive(:get_furnishing).with(specific_type).and_return(specific_furnishing)
        expect(Section).to receive(:new).with(feature_index).and_return(feature)
        subject = described_class.build(house: house, feature: feature_index, furnishings: furnishings)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The bathroom<span class=\"icon-bathroom\"><\/span> must not contain a lamp<span class=\"icon-lamp\"><\/span>")
      end
    end
  end
end
