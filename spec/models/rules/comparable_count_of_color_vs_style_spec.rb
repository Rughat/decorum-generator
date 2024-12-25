require "rails_helper"

RSpec.describe ComputedRule::ComparableCountOfColorVsStyle do
  describe ".random_feature" do
    it "calls and returns a random color and style" do
      expect(Color).to receive(:random_color).and_return(Color.new("blue"))
      expect(Style).to receive(:random).and_return("retro")
      expect(described_class.random_feature.to_s).to eq("blue-retro")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:color) { Color.new("blue") }
    let(:style) { "retro" }
    let(:feature) { "blue-retro" }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house when there is fewer of the style than of the color in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(Color).to receive(:new).with("blue").and_return(color)
      expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(4)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain fewer retro<span class=\"icon-retro\"><\/span> objects than <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
    end

    it "randomly builds a rule from the given house when there is more of the style than of the color in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(Color).to receive(:new).with("blue").and_return(color)
      expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(2)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain more retro<span class=\"icon-retro\"><\/span> objects than <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
    end

    it "randomly builds a rule from the given house when there is an equal amount of the style and of the color in the section" do
      expect(sections).to receive(:random_multiroom).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(Color).to receive(:new).with("blue").and_return(color)
      expect(house).to receive(:count_colors).with(color: color, section: selected_section).and_return(3)
      expect(house).to receive(:count_styles).with(style: style, section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: feature, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain an equal number of retro<span class=\"icon-retro\"><\/span> objects and <span class=\"blue\">blue<\/span> features (as objects and/or wall colors)")
    end
  end
end
