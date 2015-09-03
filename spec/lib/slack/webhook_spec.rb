require 'rails_helper'

module Slack
  RSpec.describe Webhook do
    before do
      allow(Webhook).to receive(:webhook_url).and_return 'https://www.example.com/'
      Rails.application.routes.default_url_options[:host] = 'example.org'
    end

    describe '.trigger' do
      it 'posts to the webook URL' do
        stub_request(:any, "https://www.example.com/")
        Webhook.trigger(:create, FactoryGirl.create(:timesheet_entry))
        expect(WebMock).to have_requested(:post, 'https://www.example.com')
      end
    end
  end
end
