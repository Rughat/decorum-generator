class Furnishing < Token
  def self.random
    self.subclasses.sample
  end
end
