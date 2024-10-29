require "rails_helper"

RSpec.describe House, type: :model do
  describe ".generate" do
    it "creates a house" do
      house = described_class.generate
      expect(house).to be_a(described_class)
      expect(house.rooms).to all(be_a(Room)).and have_exactly(4).items
    end
  end

  describe "#count_colors" do
    let(:subject) { build(:house) }
    let(:color) { "blue" }
    let(:section) { double }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    it "returns the expected number of colors" do
      expect(section).to receive(:rooms).exactly(4).times.and_return(["bedroom", "bathroom"])
      expect(living_room).not_to receive(:count_colors)
      expect(kitchen).not_to receive(:count_colors)
      allow(bedroom).to receive(:count_colors).with(color).and_return(2)
      allow(bathroom).to receive(:count_colors).with(color).and_return(1)
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.count_colors(color: color, section: section)).to eq(3)
    end
  end

  describe "#count_styles" do
    let(:subject) { build(:house) }
    let(:style) { "modern" }
    let(:section) { double }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    it "returns the expected number of styles" do
      expect(section).to receive(:rooms).exactly(4).times.and_return(["kitchen", "living_room"])
      expect(living_room).to receive(:count_styles).with(style).and_return(1)
      expect(kitchen).to receive(:count_styles).with(style).and_return(0)
      expect(bedroom).not_to receive(:count_styles)
      expect(bathroom).not_to receive(:count_styles)
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.count_styles(style: style, section: section)).to eq(1)
    end
  end

  describe "#count_furnishings" do
    let(:subject) { build(:house) }
    let(:furnishing) { "lamp" }
    let(:section) { double }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    it "returns the expected number of furnishings" do
      expect(section).to receive(:rooms).exactly(4).times.and_return(["bedroom", "bathroom"])
      expect(living_room).not_to receive(:count_furnishings)
      expect(kitchen).not_to receive(:count_furnishings)
      allow(bedroom).to receive(:count_furnishings).with(furnishing).and_return(0)
      allow(bathroom).to receive(:count_furnishings).with(furnishing).and_return(1)
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.count_furnishings(furnishing: furnishing, section: section)).to eq(1)
    end
  end
end
