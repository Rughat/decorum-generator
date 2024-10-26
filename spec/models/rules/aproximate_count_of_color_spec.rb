require 'rails_helper'

RSpec.describe ComputedRule::AproximateCountOfColor do
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
    let(:randomizer) { class_double(Kernel) }

    it "randomly builds a maximal rule from the given house" do
      pending
      expect(colors).to receive(:random).and_return("red")
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:rooms).and_return(["test", "rooms"])
      expect(house).to receive(:count_colors).with(color: "red", section: selected_section).and_return(3)
      expect(randomizer).to receive(:rand).with(3).and_return(2)
      subject = described_class.build(house: house, colors: colors, sections: sections, randomizer: randomizer)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain at most 4 red features (as objects and/or wall colors)")
    end

    it "randomly builds a minimum rule from the given house" do
      pending
      expect(colors).to receive(:random).and_return("red")
      expect(sections).to receive(:random).and_return(selected_section)
      expect(selected_section).to receive(:name).and_return("top floor")
      expect(selected_section).to receive(:rooms).and_return(["test", "rooms"])
      expect(house).to receive(:count_colors).with(color: "red", section: selected_section).and_return(3)
      expect(randomizer).to receive(:rand).with(3).and_return(0)
      subject = described_class.build(house: house, colors: colors, sections: sections, randomizer: randomizer)
      expect(subject).to be_a(described_class)
      expect(subject.text).to eq("The top floor must contain at least 2 red features (as objects and/or wall colors)")
    end
  end
end
