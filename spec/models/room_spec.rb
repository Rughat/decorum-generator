require 'rails_helper'

RSpec.describe Room, type: :model do
  it "generates a random room" do
    room = described_class.generate(room_type: "bedroom")
    expect(room.name).to eq("Bedroom")
    expect(room.side).to eq("right")
    expect(room.floor).to eq("top")
    expect(room.color).to be_in(Colors::ALL)
    expect(room.tokens).to all(be_a(Furnishing)).and have_exactly(3).items
  end

  it "knows how to generate each type of room" do
    subject = described_class.generate(room_type: "living_room")
    expect(subject.name).to eq("Living Room")
    expect(subject.side).to eq("left")
    expect(subject.floor).to eq("bottom")

    subject = described_class.generate(room_type: "kitchen")
    expect(subject.name).to eq("Kitchen")
    expect(subject.side).to eq("right")
    expect(subject.floor).to eq("bottom")

    subject = described_class.generate(room_type: "bathroom")
    expect(subject.name).to eq("Bathroom")
    expect(subject.side).to eq("left")
    expect(subject.floor).to eq("top")
  end

  describe "#count_styles" do
    let(:subject) { described_class.new }

    it "knows how to count the styles of the room" do
      subject.tokens.append(Lamp.new(color: "red"))
      subject.tokens.append(Curio.new(color: "red"))
      subject.tokens.append(EmptyFurnishing.new)
      expect(subject.count_styles(:retro)).to eq(1)
      expect(subject.count_styles(:unusual)).to eq(1)
      expect(subject.count_styles(:antique)).to eq(0)
    end
  end

  describe "#count_colors" do
    let(:subject) { described_class.new }

    it "knows how to count the colors of the room" do
      subject.color = "blue"
      subject.tokens.append(Lamp.new(color: "red"))
      subject.tokens.append(Curio.new(color: "blue"))
      subject.tokens.append(EmptyFurnishing.new)
      expect(subject.count_colors("red")).to eq(1)
      expect(subject.count_colors("blue")).to eq(2)
      expect(subject.count_colors("green")).to eq(0)
    end
  end

  describe "#count_furnishings" do
    let(:subject) { described_class.new }

    it "knows how to count the furnishings of the room" do
      subject.color = "blue"
      subject.tokens.append(Lamp.new(color: "red"))
      subject.tokens.append(Curio.new(color: "blue"))
      subject.tokens.append(EmptyFurnishing.new)
      expect(subject.count_furnishings(Lamp)).to eq(1)
      expect(subject.count_furnishings(Curio)).to eq(1)
      expect(subject.count_furnishings(EmptyFurnishing)).to eq(1)
      expect(subject.count_furnishings(WallHanging)).to eq(0)
    end
  end
end
