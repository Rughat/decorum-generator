require "rails_helper"

RSpec.describe ComputedRule::RelativeCountOfStyle do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(Style).to receive(:random).and_return("modern")
      expect(described_class.random_feature).to eq("modern")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }
    let(:opposite_section) { instance_double(Section) }
    let(:feature) { Style.new("antique") }

    it "randomly builds a rule from the given house when there are more in the first section" do
      expect(Style).to receive(:new).with("antique").and_return(feature)
      expect(sections).to receive(:random_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(3)
      expect(house).to receive(:count_styles).with(style: "antique", section: opposite_section).and_return(2)
      subject = described_class.build(house: house, feature: "antique", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain more antique<span class=\"icon-antique\"><\/span> objects than the bottom floor")
    end

    it "randomly builds a rule from the given house when there are fewer in the first section" do
      expect(sections).to receive(:random_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(1)
      expect(house).to receive(:count_styles).with(style: "antique", section: opposite_section).and_return(3)
      subject = described_class.build(house: house, feature: "antique", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain fewer antique<span class=\"icon-antique\"><\/span> objects than the bottom floor")
    end

    it "randomly builds a rule from the given house when there are an equal amount in both sections" do
      expect(sections).to receive(:random_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_styles).with(style: "antique", section: selected_section).and_return(3)
      expect(house).to receive(:count_styles).with(style: "antique", section: opposite_section).and_return(3)
      subject = described_class.build(house: house, feature: "antique", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain an equal amount of antique<span class=\"icon-antique\"><\/span> objects as the bottom floor")
    end
  end
end
