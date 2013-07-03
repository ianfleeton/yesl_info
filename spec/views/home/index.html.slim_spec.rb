require 'spec_helper'

describe 'home/index' do
  it 'displays home content' do
    assign(:backups_pending, 0)
    assign(:contacts, 0)
    assign(:home_content, 'Welcome')
    render
    expect(rendered).to have_content('Welcome')
  end
end
