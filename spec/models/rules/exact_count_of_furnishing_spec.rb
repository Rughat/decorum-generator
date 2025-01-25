require "rails_helper"

RSpec.describe ComputedRule::ExactCountOfFurnishing do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Furnishing).to receive(:random).and_return(WallHanging)
      expect(described_class.random_feature).to eq("WallHanging")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }
    context "when the feature is an empty space" do
      let(:feature) { EmptyFurnishing.new }

      it "randomly builds a rule from the given house with a given feature" do
        expect(EmptyFurnishing).to receive(:new).and_return(feature)
        expect(sections).to receive(:random).and_return(selected_section)
        expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: selected_section).and_return(2)
        subject = described_class.build(house: house, feature: feature.class.to_s, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain exactly 2 empty spaces")
      end
    end

    context "when the feature is a wall hanging" do
      let(:feature) { WallHanging.new }

      it "randomly builds a rule from the given house with a given feature" do
        expect(WallHanging).to receive(:new).and_return(feature)
        expect(sections).to receive(:random).and_return(selected_section)
        expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
        expect(house).to receive(:count_furnishings).with(furnishing: feature.short_name, section: selected_section).and_return(1)
        subject = described_class.build(house: house, feature: feature.class.to_s, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain exactly 1 wall hanging<span class=\"icon-wall-hanging\"><\/span>")
      end
    end
  end
end
