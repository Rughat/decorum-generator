class EmptyWallHanging < WallHanging
  include EmptyMixin

  def icon
    "<span class=\"icon-wall-hanging\"><\/span>".html_safe
  end
end
