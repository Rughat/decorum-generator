require "rails_helper"

RSpec.describe ComputedRule::ComparableCountOfColorVsFurnishing do
  describe ".random_feature" do
    it "calls and returns a random color and furnishing" do
      expect(Color).to receive(:random_color).and_return(Color.new("blue"))
      expect(Furnishing).to receive(:random).and_return(WallHanging)
      expect(described_class.random_feature.to_s).to eq("blue-WallHanging")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:color) { Color.new("blue") }
    let(:feature) { "blue-WallHanging" }
    let(:selected_section) { instance_double(Section) }

    context "when the feature is a wall hanging" do
      let(:furnishing) { WallHanging.new }

      it "randomly builds a rule from the given house when there is fewer of the furnishing than of the color in the section" do
        expect(WallHanging).to receive(:new).and_return(furnishing)
        expect(sections).to receive(:random_multiroom).and_return(selected_section)
        expect(selected_section).to receive(:name).and_return("top floor")
        expect(Color).to receive(:new).with("blue").and_return(color)
        expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(4)
        expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
        subject = described_class.build(house: house, feature: feature, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor must contain fewer wall hangings<span class=\"icon-wall-hanging\"></span> than <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
      end

      it "randomly builds a rule from the given house when there is more of the furnishing than of the color in the section" do
        expect(WallHanging).to receive(:new).and_return(furnishing)
        expect(sections).to receive(:random_multiroom).and_return(selected_section)
        expect(selected_section).to receive(:name).and_return("top floor")
        expect(Color).to receive(:new).with("blue").and_return(color)
        expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(2)
        expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
        subject = described_class.build(house: house, feature: feature, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor must contain more wall hangings<span class=\"icon-wall-hanging\"></span> than <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
      end

      it "randomly builds a rule from the given house when there is an equal amount of the furnishing and of the color in the section" do
        expect(WallHanging).to receive(:new).and_return(furnishing)
        expect(sections).to receive(:random_multiroom).and_return(selected_section)
        expect(selected_section).to receive(:name).and_return("top floor")
        expect(Color).to receive(:new).with("blue").and_return(color)
        expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(3)
        expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
        subject = described_class.build(house: house, feature: feature, sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("The top floor must contain an equal number of wall hangings<span class=\"icon-wall-hanging\"></span> and <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
      end
    end
  end
end
