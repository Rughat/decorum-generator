class EmptyFurnishing < Furnishing
  def self.generate
    EmptyFurnishing.create
  end

  def self.short_name
    "empty space"
  end

  def long_description
    "An empty spot"
  end

  def color_obj
    nil
  end

  def style
    nil
  end
end
