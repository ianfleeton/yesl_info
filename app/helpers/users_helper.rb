module UsersHelper

  def image_for_admin_status(user) 
    if user.admin? 
      image_tag("star.gif", :alt => "Admin", :size => "16x16") 
    end 
  end 

  def gravatar(email_address)
    require 'digest/md5'
    email_address.downcase!
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "http://www.gravatar.com/avatar/#{hash}" + '?d=wavatar&amp;s=32'
    image_tag(image_src, :alt => 'Gravatar', :class => 'gravatar')
  end

end
