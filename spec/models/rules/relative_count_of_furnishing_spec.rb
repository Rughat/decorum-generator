require 'rails_helper'

RSpec.describe ComputedRule::RelativeCountOfFurnishing do
  describe ".build" do
    let(:house) { instance_double(House) }
    let(:furnishings) { class_double(Furnishing) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }
    let(:opposite_section) { instance_double(Section) }

    it "randomly builds a rule from the given house when there are more in the first section" do
      expect(furnishings).to receive(:random).and_return(Lamp)
      expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: selected_section).and_return(3)
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: opposite_section).and_return(2)
      subject = described_class.build(house: house, furnishings: furnishings, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain more lamps than the bottom floor")
    end

    it "randomly builds a rule from the given house when there are less in the first section" do
      expect(furnishings).to receive(:random).and_return(Lamp)
      expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: selected_section).and_return(1)
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: opposite_section).and_return(3)
      subject = described_class.build(house: house, furnishings: furnishings, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain less lamps than the bottom floor")
    end

    it "randomly builds a rule from the given house when there are an equal amount in both sections" do
      expect(furnishings).to receive(:random).and_return(Lamp)
      expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: selected_section).and_return(3)
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: opposite_section).and_return(3)
      subject = described_class.build(house: house, furnishings: furnishings, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor and the bottom floor must contain an equal amount of lamps")
    end

    it "randomly builds a rule from the given house when there are an equal amount in both sections with a given feature" do
      expect(sections).to receive(:random_multiroom_opposable).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:opposite).twice.and_return(opposite_section)
      expect(opposite_section).to receive(:name).and_return("bottom floor")
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: selected_section).and_return(3)
      expect(house).to receive(:count_furnishings).with(furnishing: "lamp", section: opposite_section).and_return(3)
      subject = described_class.build(house: house, feature: "lamp", sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor and the bottom floor must contain an equal amount of lamps")
    end
  end
end
