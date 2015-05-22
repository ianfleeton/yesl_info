def sign_in_as_admin
  visit '/sessions/new'
  fill_in 'Email', with: 'admin@example.org'
  fill_in 'Password', with: 'secret'
  click_button 'Login'
end

def signed_in_as_admin
  allow(controller).to receive(:admin?).and_return(true)
end
