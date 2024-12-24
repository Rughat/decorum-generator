class Style
  STYLES = ["modern", "antique", "retro", "unusual"]
  def self.random(randomizer: Kernel)
    new(STYLES[randomizer.rand(4)])
  end

  attr_reader :style

  def initialize(style)
    self.style = style
  end

  def ==(other)
    style == other.style
  end

  def to_s
    style
  end

  def icon
    "<span class=\"icon-#{style}\"><\/span>".html_safe
  end

  def display
    "#{style}#{icon}".html_safe
  end

  private

  attr_writer :style
end
