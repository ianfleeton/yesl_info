module UsersHelper

  def image_for_admin_status(user) 
    if user.admin? 
      image_tag("star.gif", :alt => "Admin", :size => "16x16") 
    end 
  end 

  def staff_options
    User.staff.map {|u| [u.name, u.id]}
  end

  def organisation_users_options(organisation)
    organisation ? organisation.users.map {|u| [u.name, u.id]} : []
  end

  def cache_key_for_users
    count          = User.count
    max_updated_at = User.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "users/all-#{count}-#{max_updated_at}"
  end
end
