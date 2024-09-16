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
end
