require 'rails_helper'

RSpec.describe ComputedRule::ExactCountOfFurnishing do
  describe ".build" do
    let(:house) { instance_double(House) }
    let(:furnishings) { class_double(Furnishing) }
    let(:sections) { class_double(Section) }
    let(:selected_section) { instance_double(Section) }

    it "randomly builds a rule from the given house" do
      expect(furnishings).to receive(:random).and_return(EmptyFurnishing)
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(house).to receive(:count_furnishings).with(furnishing: EmptyFurnishing, section: selected_section).and_return(2)
      subject = described_class.build(house: house, furnishings: furnishings, sections: sections)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain exactly 2 empty spaces")
    end

  end
end
