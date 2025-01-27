class EmptyLamp < Lamp
  include EmptyMixin

  def parent_icon
    "<span class=\"icon-lamp\"><\/span>".html_safe
  end
end
