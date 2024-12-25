class EmptyCurio < Curio
  include EmptyMixin

  def icon
    "<span class=\"icon-curio\"><\/span>".html_safe
  end
end
