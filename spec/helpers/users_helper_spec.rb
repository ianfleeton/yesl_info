require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  describe '#cache_key_for_users' do
    before { FactoryBot.create(:user) }
    subject { helper.cache_key_for_users }
    it { should match(/users\/all-1-\d+/) }
  end
end
