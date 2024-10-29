class Furnishing < Token
  def self.random
    subclasses.sample
  end

  def short_name
    self.class.short_name
  end
end
