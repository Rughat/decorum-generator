class Section
  SECTION_ARRAY = [
    OpenStruct.new(index: 0, name: "whole house", rooms: ["bedroom","bathroom","kitchen","living_room"]),
    OpenStruct.new(index: 1, name: "top floor", rooms: ["bedroom","bathroom"]),
    OpenStruct.new(index: 2, name: "bottom floor", rooms: ["living_room", "kitchen"]),
    OpenStruct.new(index: 3, name: "right side", rooms: ["bedroom", "kitchen"]),
    OpenStruct.new(index: 4, name: "left side", rooms: ["living_room", "bathroom"]),
    OpenStruct.new(index: 5, name: "bedroom & living room", rooms: ["living_room", "bedroom"]),
    OpenStruct.new(index: 6, name: "bathroom & kitchen", rooms: ["bathroom", "kitchen"]),
    OpenStruct.new(index: 7, name: "bathroom", rooms: ["bathroom"]),
    OpenStruct.new(index: 8, name: "bedroom", rooms: ["bedroom"]),
    OpenStruct.new(index: 9, name: "living room", rooms: ["living_room"]),
    OpenStruct.new(index: 10, name: "kitchen", rooms: ["kitchen"])
  ]

  def self.random(randomizer: Kernel)
    self.new(randomizer.rand(SECTION_ARRAY.length))
  end

  attr_accessor :index

  def initialize(section)
    self.index = section
  end

  def name
    SECTION_ARRAY[index].name
  end

  def rooms
    SECTION_ARRAY[index].rooms
  end
end
