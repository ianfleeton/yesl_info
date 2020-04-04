require 'rails_helper'

RSpec.describe TimesheetEntriesController, type: :controller do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'triggers a Slack webhook' do
      expect(Slack::Webhook).to receive(:trigger)
      post :create, params: {timesheet_entry: { description: 'Some work', started_at: Time.now, organisation_id: FactoryGirl.create(:organisation).id }}
    end

    it 'swallows webhook errors' do
      allow(Slack::Webhook).to receive(:trigger).and_raise(URI::InvalidURIError)
      te = double(TimesheetEntry, save: true, organisation: FactoryGirl.build_stubbed(:organisation))
      allow(TimesheetEntry).to receive(:new).and_return(te)
      post :create, params: {timesheet_entry: { description: 'Some work', started_at: Time.current, organisation_id: 1 }}
    end
  end

  describe 'GET report' do
    it 'renders the report template' do
      pending 'remove assert_template'
      get 'report'
      expect(response).to render_template 'report'
    end
  end

  describe 'POST generate_report' do
    it 'renders the report template' do
      pending 'remove assert_template'
      post_valid_generate_report
      expect(response).to render_template 'report'
    end

    it 'assigns @timesheet_entries' do
      pending 'remove assigns'
      post_valid_generate_report
      expect(assigns(:timesheet_entries)).to_not be_nil
    end
  end

  def post_valid_generate_report
    post 'generate_report', report: {
      'start(1i)' => '2012', 'start(2i)' => '08', 'start(3i)' => '13',
      'end(1i)' => '2013', 'end(2i)' => '06', 'end(3i)' => '29'
    }
  end

  def signed_in_as_admin
    allow(controller).to receive(:admin?).and_return(true)
  end
end
