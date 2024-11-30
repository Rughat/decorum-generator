class Furnishing < Token
  def self.random
    subclasses.sample
  end

  def self.random_real
    subclasses.reject(&:empty?).sample
  end

  def self.random_aspect
    ["color", "style", "furnishing"]
  end

  def self.empty?
    false
  end

  def short_name
    self.class.short_name
  end

  def empty?
    false
  end
end
