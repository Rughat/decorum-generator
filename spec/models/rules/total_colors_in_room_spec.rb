require "rails_helper"

RSpec.describe ComputedRule::TotalColorsInRoom do
  describe ".random_feature" do
    it "calls and returns a random feature" do
      expect(described_class.random_feature.to_s).to eq("singular_rule")
    end
  end

  describe ".build" do
    let(:house) { instance_double(House) }
    let(:sections) { class_double(Section) }
    let(:rooms) { [room1, room2, room3, room4] }
    let(:room1) { instance_double(Section) }
    let(:room2) { instance_double(Section) }
    let(:room3) { instance_double(Section) }
    let(:room4) { instance_double(Section) }


    context "when the house has a room with four different colors in it" do
      it "builds the rule requiring that there be such a room in the house" do
        expect(sections).to receive(:all_rooms).and_return(rooms)
        expect(house).to receive(:get_distinct_colors).with(section: room1).and_return(["red"])
        expect(house).to receive(:get_distinct_colors).with(section: room2).and_return(["red","blue"])
        expect(house).to receive(:get_distinct_colors).with(section: room3).and_return(["red","blue", "green"])
        expect(house).to receive(:get_distinct_colors).with(section: room4).and_return(["red", "blue", "green", "yellow"])
        subject = described_class.build(house: house, feature: "singular_rule", sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("There must be at least one room in the house with all four colors (as objects and/or wall color)")
      end
    end

    context "when the house has a room with three colors in it" do
      it "builds the rule requring that the most colors in any one room be three" do
        expect(sections).to receive(:all_rooms).and_return(rooms)
        expect(house).to receive(:get_distinct_colors).with(section: room1).and_return(["red"])
        expect(house).to receive(:get_distinct_colors).with(section: room2).and_return(["red","blue"])
        expect(house).to receive(:get_distinct_colors).with(section: room3).and_return(["red","blue", "green"])
        expect(house).to receive(:get_distinct_colors).with(section: room4).and_return([])
        subject = described_class.build(house: house, feature: "singular_rule", sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("There must not be any room with all four colors in the house (as objects and/or wall color)")
      end
    end

    context "when the house has a room with two colors in it" do
      it "builds the rule requring that the most colors in any one room be two" do
        expect(sections).to receive(:all_rooms).and_return(rooms)
        expect(house).to receive(:get_distinct_colors).with(section: room1).and_return(["red"])
        expect(house).to receive(:get_distinct_colors).with(section: room2).and_return(["red","blue"])
        expect(house).to receive(:get_distinct_colors).with(section: room3).and_return(["green", "yellow"])
        expect(house).to receive(:get_distinct_colors).with(section: room4).and_return([])
        subject = described_class.build(house: house, feature: "singular_rule", sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("There must not be more than two different colors in any room (as objects and/or wall color)")
      end
    end

    context "when the house has no room with more than one color in it" do
      it "builds the rule requring that the most colors in any one room be one" do
        expect(sections).to receive(:all_rooms).and_return(rooms)
        expect(house).to receive(:get_distinct_colors).with(section: room1).and_return(["red"])
        expect(house).to receive(:get_distinct_colors).with(section: room2).and_return(["blue"])
        expect(house).to receive(:get_distinct_colors).with(section: room3).and_return(["green"])
        expect(house).to receive(:get_distinct_colors).with(section: room4).and_return([])
        subject = described_class.build(house: house, feature: "singular_rule", sections: sections)
        expect(subject).to be_a(described_class)
        expect(subject.text).to eq("Every feature and object in a room must be the same color")
      end
    end
  end
end
