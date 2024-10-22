class Furnishing < Token
  def self.random
    self.subclasses.sample
  end

  def short_name
    self.class.short_name
  end
end
