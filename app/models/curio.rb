class Curio < Furnishing
  def self.random
    [Curio, Curio, Curio, EmptyCurio].sample.generate
  end

  def self.short_name
    "curio"
  end

  def self.generate
    curio = Curio.new
    curio.color = Color.random
    curio.save
    curio
  end

  def style
    case color_obj.to_s
    when "green" then "modern"
    when "blue" then "antique"
    when "yellow" then "retro"
    when "red" then "unusual"
    end
  end

  def long_description
    "A #{color_obj.display} #{style_obj.display} curio#{icon}".html_safe
  end

  def color_obj
    @color ||= Color.new(color)
  end

  def style_obj
    @style ||= Style.new(style)
  end

  def icon
    "<span class=\"icon-curio\"><\/span>".html_safe
  end
end
