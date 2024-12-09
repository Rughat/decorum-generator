require "rails_helper"

RSpec.describe ComputedRule::ComparableCountOfStyleVsFurnishing do
  describe ".random_feature" do
    it "calls and returns a random style and furnishing" do
      expect(Style).to receive(:random).and_return("retro")
      expect(Furnishing).to receive(:random).and_return(WallHanging)
      expect(described_class.random_feature.to_s).to eq("retro-wall hanging")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:style) { "retro" }
    let(:furnishing) { "wall hanging" }
    let(:feature) { "retro-wall hanging" }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house when there is less of the furnishing than of the style in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(4)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain less wall hangings than retro features")
    end

    it "randomly builds a rule from the given house when there is more of the furnishing than of the style in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(2)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain more wall hangings than retro features")
    end

    it "randomly builds a rule from the given house when there is an equal amount of the furnishing and of the style in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(3)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain an equal number of wall hangings and retro features")
    end
  end
end
