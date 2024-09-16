class EmptyFurnishing < Furnishing
  def self.generate
    EmptyFurnishing.create
  end

  def long_description
    "An empty spot"
  end
end
