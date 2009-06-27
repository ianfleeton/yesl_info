# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def flash_notice 
    if flash[:notice] 
      content_tag('div', h(flash[:notice]), {:id => "flash_notice"}) 
    end
  end

  def alpha_links
    letters = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
    html = '<ul id="alpha">'
    letters.each do |l|
  	  html += '<li class="alpha_' + l + '"><a href="#alphanum' + l + '">' + l + '</a></li>'
    end
    html += '</ul>'
  end
end
