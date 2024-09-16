class Lamp < Furnishing
  def self.random
    [Lamp, EmptyFurnishing].sample.generate
  end

  def self.generate
    lamp = Lamp.new
    lamp.color = Colors.random
    lamp.save
    lamp
  end

  def style
    case color
    when "blue" then "modern"
    when "yellow" then "antique"
    when "red" then "retro"
    when "green" then "unusual"
    end
  end

  def long_description
    "A #{color} #{style} lamp"
  end
end
