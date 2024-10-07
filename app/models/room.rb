class Room < ApplicationRecord
  belongs_to :house
  has_many :tokens

  LEFT_SIDE_ROOMS = ["bathroom", "living_room"]
  BOTTOM_FLOOR_ROOMS = ["kitchen", "living_room"]

  def self.generate(room_type:)
    room = Room.create(room_type: room_type)
    room.color = Colors.random
    room.tokens.append(Lamp.random)
    room.tokens.append(Curio.random)
    room.tokens.append(WallHanging.random)
    room.save
    room
  end

  def count_styles(style)
    tokens.count { |token| token.style == style.to_s}
  end

  def count_colors(test_color)
    tokens.count { |token| token.color == test_color } +
        (color == test_color ? 1 : 0)
  end

  def count_furnishings(furnishing)
    tokens.count { |token| token.class == furnishing }
  end

  def name
    room_type.gsub('_',' ').titleize
  end

  def room_html_id
    "room-layout-#{room_type.gsub('_','-')}"
  end

  def side
    LEFT_SIDE_ROOMS.include?(room_type) ? "left" : "right"
  end

  def floor
    BOTTOM_FLOOR_ROOMS.include?(room_type) ? "bottom" : "top"
  end
end
