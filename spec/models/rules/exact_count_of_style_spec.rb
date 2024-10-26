require 'rails_helper'

RSpec.describe ComputedRule::ExactCountOfStyle do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Style).to receive(:random).and_return("modern")
      expect(described_class.random_feature).to eq("modern")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:styles) { class_double(Style) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house" do
      expect(styles).to receive(:random).and_return("antique")
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(3)
      subject = described_class.build(house: house, styles: styles, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain exactly 3 antique objects")
    end

    it "randomly builds a rule from the given house with a given feature" do
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: "antique", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain exactly 3 antique objects")
    end
  end
end
