class Style
  STYLES = [:modern, :antique, :retro, :unusual]
  def self.random(randomizer: Kernel)
    STYLES[randomizer.rand(4)]
  end
end
