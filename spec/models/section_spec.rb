require 'rails_helper'

RSpec.shared_examples "a section object" do |subject, name, rooms, index|
  let(:randomizer) { class_double(Kernel) }

  it "should return #{name} as the name" do
    expect(subject.name).to eq(name)
  end

  it "should include the rooms #{rooms.join(', ')}" do
    expect(subject.rooms).to match_array(rooms)
  end

  it "should be returned when the random index is #{index}" do
    expect(randomizer).to receive(:rand).with(11).and_return(index)
    expect(described_class.random(randomizer: randomizer).name).to eq(name)
  end
end

RSpec.shared_examples "an opposable section object" do |subject, name, rooms, index, opposite_index|
  it_should_behave_like "a section object", subject, name, rooms, index

  it "should have an opposite section" do
    expect(subject.opposite).to be_a(OpenStruct)
    expect(subject.opposite.index).to eq(opposite_index)
  end
end

RSpec.shared_examples "a non-opposable section object" do |subject, name, rooms, index|
  it_should_behave_like "a section object", subject, name, rooms, index

  it "should not have an opposite section" do
    expect(subject.opposite).to be_nil
  end
end

RSpec.shared_examples "a randomly opposable section object" do |subject, name, rooms, index, possible_opposite_indexes|
  it_should_behave_like "a section object", subject, name, rooms, index

  it "should have an opposite section in the set of possible opposites" do
    expect(possible_opposite_indexes).to include(subject.opposite.index)
  end
end

RSpec.describe Section do
  it_should_behave_like "a non-opposable section object", described_class.new(0), "whole house", ["bathroom", "bedroom", "kitchen", "living_room"], 0
  it_should_behave_like "an opposable section object", described_class.new(1), "top floor", ["bathroom", "bedroom"], 1, 2
  it_should_behave_like "an opposable section object", described_class.new(2), "bottom floor", ["living_room", "kitchen"], 2, 1
  it_should_behave_like "an opposable section object", described_class.new(3), "right side", ["bedroom", "kitchen"], 3, 4
  it_should_behave_like "an opposable section object", described_class.new(4), "left side", ["living_room", "bathroom"], 4, 3
  it_should_behave_like "an opposable section object", described_class.new(5), "bedroom & living room", ["living_room", "bedroom"], 5, 6
  it_should_behave_like "an opposable section object", described_class.new(6), "bathroom & kitchen", ["bathroom", "kitchen"], 6, 5
  it_should_behave_like "a randomly opposable section object", described_class.new(7), "bathroom", ["bathroom"], 7, [8, 9, 10]
  it_should_behave_like "a randomly opposable section object", described_class.new(8), "bedroom", ["bedroom"], 8, [7, 9, 10]
  it_should_behave_like "a randomly opposable section object", described_class.new(9), "living room", ["living_room"], 9, [7, 8, 10]
  it_should_behave_like "a randomly opposable section object", described_class.new(10), "kitchen", ["kitchen"], 10, [7, 8, 9]

  it "should only give random opposable values" do
    randomizer = class_double(Kernel)
    expect(randomizer).to receive(:rand).with(10).and_return(0)
    expect(described_class.random_opposable(randomizer: randomizer).name).to eq("top floor")
  end
end


