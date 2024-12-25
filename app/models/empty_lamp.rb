class EmptyLamp < Lamp
  include EmptyMixin

  def icon
    "<span class=\"icon-lamp\"><\/span>".html_safe
  end
end
