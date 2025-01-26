class EmptyWallHanging < WallHanging
  include EmptyMixin

  def parent_icon
    "<span class=\"icon-wall-hanging\"><\/span>".html_safe
  end
end
