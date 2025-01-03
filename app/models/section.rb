require "ostruct"

class Section
  SECTION_ARRAY = [
    OpenStruct.new(index: 0, name: "whole house", rooms: ["bedroom", "bathroom", "kitchen", "living_room"], opposite_index: nil),
    OpenStruct.new(index: 1, name: "top floor", rooms: ["bedroom", "bathroom"], opposite_index: 2),
    OpenStruct.new(index: 2, name: "bottom floor", rooms: ["living_room", "kitchen"], opposite_index: 1),
    OpenStruct.new(index: 3, name: "right side", rooms: ["bedroom", "kitchen"], opposite_index: 4),
    OpenStruct.new(index: 4, name: "left side", rooms: ["living_room", "bathroom"], opposite_index: 3),
    OpenStruct.new(index: 5, name: "bedroom & living room", rooms: ["living_room", "bedroom"], opposite_index: 6),
    OpenStruct.new(index: 6, name: "bathroom & kitchen", rooms: ["bathroom", "kitchen"], opposite_index: 5),
    OpenStruct.new(index: 7, name: "bathroom", rooms: ["bathroom"], opposite_indexes: [8, 9, 10]),
    OpenStruct.new(index: 8, name: "bedroom", rooms: ["bedroom"], opposite_indexes: [7, 9, 10]),
    OpenStruct.new(index: 9, name: "living room", rooms: ["living_room"], opposite_indexes: [7, 8, 10]),
    OpenStruct.new(index: 10, name: "kitchen", rooms: ["kitchen"], opposite_indexes: [7, 8, 9])
  ]

  def self.random(randomizer: Kernel)
    new(randomizer.rand(SECTION_ARRAY.length))
  end

  def self.random_opposable(randomizer: Kernel)
    new(randomizer.rand(SECTION_ARRAY.length - 1) + 1)
  end

  def self.random_multiroom(randomizer: Kernel)
    new(randomizer.rand(7))
  end

  def self.random_multiroom_opposable(randomizer: Kernel)
    new(randomizer.rand(6) + 1)
  end

  def self.random_single(randomizer: Kernel)
    new(randomizer.rand(4) + 7)
  end

  def self.all_rooms
    (7..10).map { |number| new(number) }
  end

  attr_accessor :index, :opposite_index

  def initialize(section)
    self.index = section
    self.opposite_index = if SECTION_ARRAY[index].opposite_indexes
      SECTION_ARRAY[index].opposite_indexes.sample
    else
      SECTION_ARRAY[index].opposite_index
    end
  end

  def name
    SECTION_ARRAY[index].name
  end

  def rooms
    SECTION_ARRAY[index].rooms
  end

  def opposite
    opposite_index ? SECTION_ARRAY[opposite_index] : nil
  end

  def to_s
    name
  end
end
