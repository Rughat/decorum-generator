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

  describe "#count_duplicate_furnishings" do
    let(:subject) { build(:house) }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    let(:living_room_tokens) { [Lamp.new(color: "red"), EmptyCurio.new, EmptyWallHanging.new] }
    let(:bedroom_tokens) { [Curio.new(color: "blue"), Lamp.new(color: "red"), WallHanging.new(color: "green")] }
    let(:kitchen_tokens) { [EmptyCurio.new, EmptyLamp.new, EmptyWallHanging.new] }
    let(:bathroom_tokens) { [Curio.new(color: "blue"), Lamp.new(color: "yellow"), WallHanging.new(color: "blue")] }

    it "returns the expected number of furnishings" do
      allow(bedroom).to receive(:tokens).and_return(bedroom_tokens)
      allow(bathroom).to receive(:tokens).and_return(bathroom_tokens)
      allow(living_room).to receive(:tokens).and_return(living_room_tokens)
      allow(kitchen).to receive(:tokens).and_return(kitchen_tokens)
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.count_duplicate_furnishing).to eq(2)
    end
  end
  describe "#get_distinct_colors" do
    let(:subject) { build(:house) }
    let(:color) { "blue" }
    let(:section) { instance_double(Section) }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    it "returns the expected number of colors" do
      expect(section).to receive(:rooms).exactly(4).times.and_return(["kitchen", "bedroom"])
      expect(living_room).not_to receive(:get_distinct_colors)
      expect(bathroom).not_to receive(:get_distinct_colors)
      expect(bedroom).to receive(:get_distinct_colors).and_return(["red","blue"])
      allow(kitchen).to receive(:get_distinct_colors).and_return(["red","green"])
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.get_distinct_colors(section: section)).to contain_exactly("red","blue","green")
    end
  end

  describe "#wall_colors" do
    let(:subject) { build(:house) }
    let(:section) { instance_double(Section) }
    let(:living_room) { build(:room, room_type: "living_room", color: "red") }
    let(:bedroom) { build(:room, room_type: "bedroom", color: "blue") }
    let(:kitchen) { build(:room, room_type: "kitchen", color: "red") }
    let(:bathroom) { build(:room, room_type: "bathroom", color: "green") }

    it "returns the list of wall colors" do
      subject.rooms.append(living_room)
      subject.rooms.append(bedroom)
      subject.rooms.append(bathroom)
      subject.rooms.append(kitchen)

      expect(subject.wall_colors).to contain_exactly("red","blue","red","green")
    end

  end

  describe "#get_majority" do
    let(:subject) { build(:house) }
    let(:living_room) { build(:room, room_type: "living_room") }
    let(:bedroom) { build(:room, room_type: "bedroom") }
    let(:kitchen) { build(:room, room_type: "kitchen") }
    let(:bathroom) { build(:room, room_type: "bathroom") }

    context "for color" do
      it "returns the color that appears the most in all of the rooms" do
        subject.rooms.append(living_room)
        subject.rooms.append(bedroom)
        subject.rooms.append(bathroom)
        subject.rooms.append(kitchen)
        expect(living_room).to receive(:color_array).and_return(["blue","red","green"])
        expect(bedroom).to receive(:color_array).and_return(["yellow","green","green"])
        expect(kitchen).to receive(:color_array).and_return(["blue","blue","red","green"])
        expect(bathroom).to receive(:color_array).and_return(["red","green"])
        expect(subject.get_majority("color")).to eq("green")
      end
    end

    context "for style" do
      it "returns the style that appears the most in all of the rooms" do
        subject.rooms.append(living_room)
        subject.rooms.append(bedroom)
        subject.rooms.append(bathroom)
        subject.rooms.append(kitchen)
        expect(living_room).to receive(:style_array).and_return(["modern","modern","retro"])
        expect(bedroom).to receive(:style_array).and_return(["antique"])
        expect(kitchen).to receive(:style_array).and_return(["unusual","retro"])
        expect(bathroom).to receive(:style_array).and_return(["retro"])
        expect(subject.get_majority("style")).to eq("retro")
      end
    end

    context "for furnishing" do
      it "returns the furnishing that appears the most in all of the rooms" do
        subject.rooms.append(living_room)
        subject.rooms.append(bedroom)
        subject.rooms.append(bathroom)
        subject.rooms.append(kitchen)
        expect(living_room).to receive(:furnishing_array).and_return(["Lamp","WallHanging","Curio"])
        expect(bedroom).to receive(:furnishing_array).and_return(["Lamp"])
        expect(kitchen).to receive(:furnishing_array).and_return(["WallHanging","Curio"])
        expect(bathroom).to receive(:furnishing_array).and_return(["Lamp"])
        expect(subject.get_majority("furnishing")).to eq("Lamp")
      end
    end
  end
end
