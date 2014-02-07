require 'spec_helper'
require_relative 'show_shared'

describe 'organisations/show_admin.html.slim' do
  before do
    view.stub(:current_user).and_return(FactoryGirl.create(:admin))
  end

  it_behaves_like 'a show organisation page'
end
