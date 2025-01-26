class EmptyCurio < Curio
  include EmptyMixin

  def parent_icon
    "<span class=\"icon-curio\"><\/span>".html_safe
  end
end
