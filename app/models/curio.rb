class Curio < Furnishing
  def self.random
    [Curio, Curio, Curio, EmptyFurnishing].sample.generate
  end

  def self.short_name
    "curio"
  end

  def self.generate
    curio = Curio.new
    curio.color = Colors.random
    curio.save
    curio
  end

  def style
    case color
    when "green" then "modern"
    when "blue" then "antique"
    when "yellow" then "retro"
    when "red" then "unusual"
    end
  end

  def long_description
    "A #{color} #{style} curio"
  end
end
