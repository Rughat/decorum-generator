class WallHanging < Furnishing
  def self.random
    [WallHanging, WallHanging, WallHanging, EmptyWallHanging].sample.generate
  end

  def self.short_name
    "wall hanging"
  end

  def self.generate
    wall_hanging = WallHanging.new
    wall_hanging.color = Color.random
    wall_hanging.save
    wall_hanging
  end

  def style
    case color_obj.to_s
    when "red" then "modern"
    when "green" then "antique"
    when "blue" then "retro"
    when "yellow" then "unusual"
    end
  end

  def long_description
    "A #{color_obj.display} #{style} wall hanging#{icon}".html_safe
  end

  def color_obj
    @color ||= Color.new(color)
  end

  def icon
    "<span class=\"icon-wall-hanging\"><\/span>".html_safe
  end
end
