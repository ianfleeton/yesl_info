require 'rails_helper'

RSpec.describe 'application/_search.html.slim', type: :view do
  it 'renders a search form' do
    render
    expect(rendered).to have_selector "form[action='#{search_path}'][method='get']"
  end
end
