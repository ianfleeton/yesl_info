module ToDosHelper
  def priority_options
    (1..12).map {|n| [n, n]}
  end

  def completed
    '<span class="label label-success">&radic; Completed</span>'.html_safe
  end
end
