# coding: utf-8
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_notice 
    if flash[:notice] 
      content_tag('div', h(flash[:notice]), {:id => "flash_notice"}) 
    end
  end

  def page_header(heading)
    content_tag('h1', heading, class: 'page-header')
  end

  def a_tick
    '<span class="tick">✔</span>'.html_safe
  end

  def a_cross
    '<span class="cross">✘</span>'.html_safe
  end

  def tick_cross yes, show_cross=true
    if yes
      a_tick
    elsif show_cross
      a_cross
    end
  end

  def tick yes
    tick_cross yes, false
  end

  def alpha_links
    letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    html = '<div class="btn-group">'
    letters.each do |l|
  	  html += '<a class="btn" href="#alphanum' + l + '">' + l + '</a>'
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
    link_to '<i class="icon-plus-sign"></i> Add'.html_safe,
    new_polymorphic_path(klass, args), class: 'btn', title: "Add #{klass}"
  end

  def edit_button(object)
    link_to '<i class="icon-edit"></i> Edit'.html_safe,
    edit_polymorphic_path(object),
    class: 'btn'
  end

  def mini_edit_button(object)
    link_to '<i class="icon-edit"></i> Edit'.html_safe,
    edit_polymorphic_path(object),
    class: 'btn btn-mini'
  end

  def delete_button(object)
    link_to '<i class="icon-trash icon-white"></i> Delete'.html_safe,
    object,
    data: { confirm: 'Are you sure?' },
    method: :delete,
    class: 'btn btn-danger'
  end

  def mini_delete_button(object)
    link_to '<i class="icon-trash icon-white"></i> Delete'.html_safe,
    object,
    data: { confirm: 'Are you sure?' },
    method: :delete,
    class: 'btn btn-danger btn-mini'
  end
end
