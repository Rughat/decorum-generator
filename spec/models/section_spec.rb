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

RSpec.describe Section do
  it_should_behave_like "a section object", described_class.new(0), "whole house", ["bathroom", "bedroom", "kitchen", "living_room"], 0
  it_should_behave_like "a section object", described_class.new(1), "top floor", ["bathroom", "bedroom"], 1
  it_should_behave_like "a section object", described_class.new(2), "bottom floor", ["living_room", "kitchen"], 2
  it_should_behave_like "a section object", described_class.new(3), "right side", ["bedroom", "kitchen"], 3
  it_should_behave_like "a section object", described_class.new(4), "left side", ["living_room", "bathroom"], 4
  it_should_behave_like "a section object", described_class.new(5), "bedroom & living room", ["living_room", "bedroom"], 5
  it_should_behave_like "a section object", described_class.new(6), "bathroom & kitchen", ["bathroom", "kitchen"], 6
  it_should_behave_like "a section object", described_class.new(7), "bathroom", ["bathroom"], 7
  it_should_behave_like "a section object", described_class.new(8), "bedroom", ["bedroom"], 8
  it_should_behave_like "a section object", described_class.new(9), "living room", ["living_room"], 9
  it_should_behave_like "a section object", described_class.new(10), "kitchen", ["kitchen"], 10
end
