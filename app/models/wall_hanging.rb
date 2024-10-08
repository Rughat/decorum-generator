class WallHanging < Furnishing
  def self.random
    [WallHanging, WallHanging, WallHanging, EmptyFurnishing].sample.generate
  end

  def self.short_name
    "wall hanging"
  end

  def self.generate
    wall_hanging = WallHanging.new
    wall_hanging.color = Colors.random
    wall_hanging.save
    wall_hanging
  end

  def style
    case color
    when "red" then "modern"
    when "green" then "antique"
    when "blue" then "retro"
    when "yellow" then "unusual"
    end
  end

  def long_description
    "A #{color} #{style} wall hanging"
  end
end
