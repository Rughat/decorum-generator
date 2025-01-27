require "rails_helper"

RSpec.describe ComputedRule::ComparableCountOfStyleVsFurnishing do
  describe ".random_feature" do
    it "calls and returns a random style and furnishing" do
      expect(Style).to receive(:random).and_return("retro")
      expect(Furnishing).to receive(:random).and_return(WallHanging)
      expect(described_class.random_feature.to_s).to eq("retro-WallHanging")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:style) { "retro" }
    let(:furnishing) { WallHanging.new }
    let(:feature) { "retro-WallHanging" }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house when there is fewer of the furnishing than of the style in the section" do
      expect(WallHanging).to receive(:new).and_return(furnishing)
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(4)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain fewer wall hangings<span class=\"icon-wall-hanging\"><\/span> than retro<span class=\"icon-retro\"><\/span> features")
    end

    it "randomly builds a rule from the given house when there is more of the furnishing than of the style in the section" do
      expect(WallHanging).to receive(:new).and_return(furnishing)
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(2)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain more wall hangings<span class=\"icon-wall-hanging\"><\/span> than retro<span class=\"icon-retro\"><\/span> features")
    end

    it "randomly builds a rule from the given house when there is an equal amount of the furnishing and of the style in the section" do
      expect(WallHanging).to receive(:new).and_return(furnishing)
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:display).and_return("top floor<span class=\"icon-top-floor\"></span>".html_safe)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(3)
      expect(house).to receive(:count_furnishings).with(furnishing: furnishing.short_name, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor<span class=\"icon-top-floor\"></span> must contain an equal number of wall hangings<span class=\"icon-wall-hanging\"><\/span> and retro<span class=\"icon-retro\"><\/span> features")
    end
  end
end
