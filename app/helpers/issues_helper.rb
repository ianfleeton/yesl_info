module IssuesHelper
  def priority_options
    (1..5).map {|n| [priority_name(n), n]}
  end

  def priority_name(priority)
    [
      'blocker',
      'critical',
      'major',
      'minor',
      'trivial'
    ][priority - 1]
  end

  def priority_icon(priority)
    glyphs = [
      'ban-circle', 'arrow-up', 'arrow-up', 'arrow-down', 'arrow-down'
    ]
    occurrences = [1, 2, 1, 1, 2]

    icon = content_tag(:span, '', title: priority_name(priority),
      class: "glyphicon glyphicon-#{glyphs[priority - 1]} priority-#{priority_name(priority)}")
    (icon * occurrences[priority - 1]).html_safe
  end

  def completed
    '<span class="label label-success">&radic; Completed</span>'.html_safe
  end

  def issue_user_options(issue)
    (staff_options + organisation_users_options(issue.organisation)).sort.uniq
  end
end
