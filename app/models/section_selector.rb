require "ostruct"

class SectionSelector
  attr_accessor :sections

  def initialize
    self.sections = (0..Section::SECTION_ARRAY.length - 1).map { |i| Section.new(i) }
  end

  def section(index)
    sections[index]
  end

  def random(randomizer: Kernel)
    sections(randomizer.rand(SECTION_ARRAY.length))
  end

  def random_opposable(randomizer: Kernel)
    sections(randomizer.rand(SECTION_ARRAY.length - 1) + 1)
  end

  def random_multiroom(randomizer: Kernel)
    sections(randomizer.rand(7))
  end

  def random_multiroom_opposable(randomizer: Kernel)
    sections(randomizer.rand(6) + 1)
  end

  def random_single(randomizer: Kernel)
    sections(randomizer.rand(4) + 7)
  end

  def all_rooms
    (7..10).map { |number| sections(number) }
  end
end
