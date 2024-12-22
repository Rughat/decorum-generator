module EmptyMixin
  def self.included(base)
    base.extend ClassMethods
  end

  def empty?
    true
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

  def icon
    ""
  end

  module ClassMethods
    def short_name
      "empty space"
    end

    def empty?
      true
    end

    def generate
      self.create
    end
  end
end
