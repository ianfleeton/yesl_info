require 'rails_helper'

RSpec.describe OrganisationsHelper, type: :helper do
  describe '#cache_key_for_organisations' do
    before { FactoryBot.create(:organisation) }
    subject { helper.cache_key_for_organisations }
    it { should match(/organisations\/all-1-\d+/) }
  end
end
