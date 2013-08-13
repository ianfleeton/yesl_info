require 'spec_helper'

describe TimesheetEntriesController do
  before { signed_in_as_admin }

  describe 'GET report' do
    it 'renders the report template' do
      get 'report'
      expect(response).to render_template 'report'
    end
  end

  describe 'POST generate_report' do
    it 'renders the report template' do
      post_valid_generate_report
      expect(response).to render_template 'report'
    end

    it 'assigns @timesheet_entries' do
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
    controller.stub(:admin?).and_return(true)
  end
end
