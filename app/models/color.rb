class Color
  ALL = ["red", "green", "yellow", "blue"]

  def self.random
    ALL.sample
  end

  def self.random_group
    (ALL + ["warm", "cool"]).sample
  end

  def self.random_color
    new(random)
  end

  def self.random_colorgroup
    new(random_group)
  end

  attr_reader :color

  def initialize(color)
    self.color = color
  end

  def to_s
    case color
    when "cool"
      "cool (blue or green)"
    when "warm"
      "warm (red or yellow)"
    else
      color
    end
  end

  def equal?(other)
    case color
    when "cool"
      other.to_s == "blue" || other.to_s == "green"
    when "warm"
      other.to_s == "red" || other.to_s == "yellow"
    else
      if other.respond_to?(:color)
        case other&.color
        when "cool"
          color == "blue" || color == "green"
        when "warm"
          color == "red" || color == "yellow"
        else
          other.to_s == color
        end
      else
        other.to_s == color
      end
    end
  end

  private

  attr_writer :color
end
