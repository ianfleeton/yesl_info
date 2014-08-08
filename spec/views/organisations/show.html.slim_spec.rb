require 'rails_helper'
require_relative 'show_shared'

describe 'organisations/show.html.slim' do
  it_behaves_like 'a show organisation page'
end
