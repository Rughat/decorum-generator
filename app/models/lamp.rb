class Lamp < Furnishing
  def self.random
    [Lamp, Lamp, Lamp, EmptyLamp].sample.generate
  end

  def self.short_name
    "lamp"
  end

  def self.generate
    lamp = Lamp.new
    lamp.color = Color.random
    lamp.save
    lamp
  end

  def style
    case color_obj.to_s
    when "blue" then "modern"
    when "yellow" then "antique"
    when "red" then "retro"
    when "green" then "unusual"
    end
  end

  def long_description
    "A #{color_obj.display} #{style_obj.display} lamp#{icon}".html_safe
  end

  def color_obj
    @color ||= Color.new(color)
  end

  def style_obj
    @style ||= Style.new(style)
  end

  def icon
    "<span class=\"icon-lamp\"><\/span>".html_safe
  end
end
