class Room < ApplicationRecord
  belongs_to :house
  has_one :lamp
  has_one :curio
  has_one :wall_hanging

  LEFT_SIDE_ROOMS = ["bathroom", "living_room"]
  BOTTOM_FLOOR_ROOMS = ["kitchen", "living_room"]

  def self.generate(room_type:)
    room = Room.create(room_type: room_type)
    room.color = Color.random
    room.lamp = Lamp.random
    room.curio = Curio.random
    room.wall_hanging = WallHanging.random
    room.save
    room
  end

  def tokens
    [curio, lamp, wall_hanging]
  end

  def non_empty_furnishings
    tokens.reject(&:empty?)
  end

  def style_array
    non_empty_furnishings.map(&:style)
  end

  def color_array
    non_empty_furnishings.map(&:color).map(&:to_s) + [color.to_s]
  end

  def furnishing_array
    non_empty_furnishings.map(&:short_name)
  end

  def count_styles(test_style)
    tokens.count { |token| token.style == test_style }
  end

  def count_different_styles
    tokens.reject {|t| t.empty? }.map(&:style).uniq.count
  end

  def count_colors(test_color)
    tokens.count { |token| test_color.equal?(token.color_obj) } +
      (test_color.equal?(color) ? 1 : 0)
  end

  def get_distinct_colors
    (tokens.reject {|t| t.empty? }.map { |token| token.color } + [color]).map(&:to_s).uniq
  end

  def count_furnishings(test_furnishing)
    tokens.count { |token| token.short_name == test_furnishing }
  end

  def get_furnishing(test_furnishing)
    tokens.to_a.find(lambda { EmptyFurnishing.new }) { |token| token.class == test_furnishing }
  end

  def name
    lower_name.tr("_", " ").titleize
  end

  def lower_name
    room_type.tr("_", " ")
  end

  def room_html_id
    "room-layout-#{room_type.tr("_", "-")}"
  end

  def side
    LEFT_SIDE_ROOMS.include?(room_type) ? "left" : "right"
  end

  def floor
    BOTTOM_FLOOR_ROOMS.include?(room_type) ? "bottom" : "top"
  end

  def color_obj
    @color ||= Color.new(color)
  end
end
