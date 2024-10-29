require "rails_helper"

RSpec.describe ComputedRule::ExactCountOfColor do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Colors).to receive(:random).and_return("yellow")
      expect(described_class.random_feature).to eq("yellow")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:colors) { class_double(Colors) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house" do
      expect(colors).to receive(:random).and_return("red")
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_colors).with(color: "red", section: selected_section).and_return(3)
      subject = described_class.build(house: house, colors: colors, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain exactly 3 red features (as objects and/or wall colors)")
    end

    it "randomly builds a rule from the given house with a given feature" do
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_colors).with(color: "red", section: selected_section).and_return(3)
      subject = described_class.build(house: house, feature: "red", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain exactly 3 red features (as objects and/or wall colors)")
    end
  end
end
