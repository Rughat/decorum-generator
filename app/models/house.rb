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

  def count_objects(section:)
    rooms.select { |room| section.rooms.include?(room.room_type) }
      .sum { |room| room.non_empty_furnishings.count }
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

  def count_duplicate_furnishing
    rooms
      .map(&:tokens)
      .flatten
      .reject(&:empty?)
      .map(&:long_description)
      .tally
      .values
      .reject {|value| value < 2 }
      .count
  end

  def get_distinct_colors(section:)
    rooms.select { |room| section.rooms.include?(room.room_type) }
      .map(&:get_distinct_colors)
      .flatten
      .uniq
  end

  def get_majority(aspect)
    aspects = rooms.map { |room| room.public_send("#{aspect}_array") }.flatten
    aspects.max_by { |curr_aspect| aspects.count(curr_aspect) }
  end

  def wall_colors
    rooms.map(&:color)
  end
end
