module ApplicationHelper
  def page_header(heading)
    content_tag('h1', heading, class: 'page-header')
  end

  def menu_links(links)
    links.map { |text, attrs| menu_link(text, attrs[0], attrs[1]) }.join.html_safe
  end

  def menu_link(text, path, title)
    content_tag(
      :li,
      link_to(text, path, title: title),
      { title: title }.merge(current_page?(path) ? { class: 'active' } : {})
    )
  end

  def a_tick
    '<span class="tick">✔</span>'.html_safe
  end

  def a_cross
    '<span class="cross">✘</span>'.html_safe
  end

  def tick_cross(val)
    val ? a_tick : a_cross
  end

  def tick(val)
    a_tick if val
  end

  def alpha_links
    letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    html = '<div class="btn-group alpha-links">'
    letters.each do |l|
  	  html += '<a class="btn btn-default" href="#alphanum' + l + '">' + l + '</a>'
    end
    html += '</div>'
  end

  def format_date d
    return 'Unknown' if d.nil?
    t = d.to_time
    if t.today?
      'Today'
    elsif (t+1.day).today?
      'Yesterday'
    elsif (Time.now - t) < 1.week
      t.strftime('%A')
    elsif t.year == Time.now.year
      t.strftime("%e %b")
    else
      t.strftime("%e %b %Y")
    end
  end

  def format_time t
    if (Time.now - t) < 2.minutes
      'Just a moment ago'
    elsif (Time.now - t) < 1.hours
      ((Time.now - t)/60).ceil.to_s + ' minutes ago'
    elsif t.today?
      'Today at ' + t.strftime("%l:%M%p").downcase
    elsif (t+1.day).today?
      'Yesterday at ' + t.strftime("%l:%M%p").downcase
    elsif (Time.now - t) < 1.week
      t.strftime('%A at ') + t.strftime("%l:%M%p").downcase
    elsif t.year == Time.now.year
      t.strftime("%e %b at ") + t.strftime("%l:%M%p").downcase
    else
      t.strftime("%e %b %Y at ") + t.strftime("%l:%M%p").downcase
    end
  end

  def add_button(klass, args = {})
    link_to '<i class="glyphicon glyphicon-plus-sign"></i> Add'.html_safe,
    new_polymorphic_path(klass, args), class: 'btn btn-success', title: "Add #{klass}"
  end

  def mini_add_icon_button(klass, args = {})
    link_to '<i class="glyphicon glyphicon-plus-sign"></i>'.html_safe,
    new_polymorphic_path(klass, args), class: 'btn btn-default btn-mini', title: "Add #{klass}"
  end

  def edit_button(object)
    link_to '<i class="glyphicon glyphicon-edit"></i> Edit'.html_safe,
    edit_polymorphic_path(object),
    title: "Edit #{object}",
    class: 'btn btn-default'
  end

  def mini_edit_button(object)
    link_to '<i class="glyphicon glyphicon-edit"></i> Edit'.html_safe,
    edit_polymorphic_path(object),
    class: 'btn btn-default btn-mini'
  end

  def delete_button(object)
    link_to '<i class="glyphicon glyphicon-trash"></i> Delete'.html_safe,
    object,
    data: { confirm: 'Are you sure?' },
    method: :delete,
    class: 'btn btn-danger'
  end

  def mini_delete_button(object)
    link_to '<i class="glyphicon glyphicon-trash"></i> Delete'.html_safe,
    object,
    data: { confirm: 'Are you sure?' },
    method: :delete,
    class: 'btn btn-danger btn-mini'
  end

  def class_for_actual_rate(rate)
    case
    when rate < 10
      'danger'
    when rate < 15 
      'warning'
    when rate > 25
      'success'
    else
      ''
    end
  end
end
