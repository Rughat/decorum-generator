require "rails_helper"

RSpec.describe Room, type: :model do
  it "generates a random room" do
    room = described_class.generate(room_type: "bedroom")
    expect(room.name).to eq("Bedroom")
    expect(room.side).to eq("right")
    expect(room.floor).to eq("top")
    expect(room.color).to be_in(Color::ALL)
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
      subject.lamp = Lamp.new(color: "red")
      subject.curio =Curio.new(color: "red")
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.count_styles("retro")).to eq(1)
      expect(subject.count_styles("unusual")).to eq(1)
      expect(subject.count_styles("antique")).to eq(0)
    end
  end

  describe "#count_different_styles" do
    let(:subject) { described_class.new }

    it "knows how to count the different styles of the room" do
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "red")
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.count_different_styles).to eq(2)
    end
  end

  describe "#get_distinct_colors" do
    let(:subject) { described_class.new }

    it "knows how to get the distinct colors of the room" do
      subject.color = "blue"
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "blue")
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.get_distinct_colors).to contain_exactly("blue","red")
    end
  end



  describe "#count_colors" do
    let(:subject) { described_class.new }

    it "knows how to count the colors of the room" do
      subject.color = "blue"
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "blue")
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.count_colors(Color.new("red"))).to eq(1)
      expect(subject.count_colors(Color.new("blue"))).to eq(2)
      expect(subject.count_colors(Color.new("green"))).to eq(0)
    end
  end

  describe "#count_furnishings" do
    let(:subject) { described_class.new }

    it "knows how to count the furnishings of the room" do
      subject.color = "blue"
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "blue")
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.count_furnishings("lamp")).to eq(1)
      expect(subject.count_furnishings("curio")).to eq(1)
      expect(subject.count_furnishings("empty space")).to eq(1)
      expect(subject.count_furnishings("wall hanging")).to eq(0)
    end
  end

  describe "#style_array" do
    let(:subject) { described_class.new }

    it "returns an array of the styles in the room" do
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "blue")
      subject.wall_hanging = WallHanging.new(color: "blue")
      expect(subject.style_array).to contain_exactly("retro","retro","antique")
    end

    it "returns an empty array if there are no objects in the room" do
      subject.lamp = EmptyLamp.new
      subject.curio = EmptyCurio.new
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.style_array).to be_empty
    end
  end

  describe "#color_array" do
    let(:subject) { described_class.new }

    it "returns an array of the colors in the room, including the wall color" do
      subject.lamp = Lamp.new(color: "red")
      subject.curio = Curio.new(color: "blue")
      subject.wall_hanging = WallHanging.new(color: "blue")
      subject.color = "green"
      expect(subject.color_array).to contain_exactly("blue","blue","green","red")
    end

    it "returns the wall color alone if there are no objects in the room" do
      subject.lamp = EmptyLamp.new
      subject.curio = EmptyCurio.new
      subject.wall_hanging = EmptyWallHanging.new
      subject.color = "green"
      expect(subject.color_array).to contain_exactly("green")
    end
  end

  describe "#furnishing_array" do
    let(:subject) { described_class.new }

    it "returns an array of the class strings of the furnishings in the room" do
      subject.lamp = Lamp.new(color: "red")
      subject.curio = EmptyCurio.new
      subject.wall_hanging = WallHanging.new(color: "blue")
      expect(subject.furnishing_array).to contain_exactly("Lamp","WallHanging")
    end

    it "returns an empty array if there are no objects in the room" do
      subject.lamp = EmptyLamp.new
      subject.curio = EmptyCurio.new
      subject.wall_hanging = EmptyWallHanging.new
      expect(subject.furnishing_array).to be_empty
    end
  end


end
