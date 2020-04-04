require 'rails_helper'

RSpec.describe DomainsHelper, type: :helper do
  describe '#cache_key_for_domains' do
    before { FactoryBot.create(:domain) }
    subject { helper.cache_key_for_domains }
    it { should match(/domains\/all-1-\d+/) }
  end
end
