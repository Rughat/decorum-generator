class House < ApplicationRecord
  has_one :scenario
  has_many :rooms

  def self.generate(player_count: "2")
    house = create
    house.rooms.append(Room.generate(room_type: "living_room"))
    house.rooms.append(Room.generate(room_type: "kitchen"))
    house.rooms.append(Room.generate(room_type: "bathroom"))
    house.rooms.append(Room.generate(room_type: "bedroom"))
    house.save
    house
  end

  def get_room(room_type)
    rooms.find { |r| r.room_type == room_type }
  end

  def count_styles(style:, section:)
    rooms.select { |room| section.rooms.include?(room.room_type) }
      .sum { |room| room.count_styles(style) }
  end

  def count_colors(color:, section:)
    rooms.select { |room| section.rooms.include?(room.room_type) }
      .sum { |room| room.count_colors(color) }
  end

  def count_furnishings(furnishing:, section:)
    rooms.select { |room| section.rooms.include?(room.room_type) }
      .sum { |room| room.count_furnishings(furnishing) }
  end
end
