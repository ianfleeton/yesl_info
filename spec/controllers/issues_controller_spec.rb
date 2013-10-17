require 'spec_helper'

describe IssuesController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only whitelisted attributes to be set' do
      post 'create', { issue: Issue.new.attributes }
      controller.send(:issue_params).keys.should eq(['assignee_id', 'date_due', 'details',
        'estimated_time', 'organisation_id', 'priority', 'setter_id', 'title'])
    end
  end

  describe 'GET calendar' do
    it 'finds all issues' do
      Issue.should_receive(:all)
      get 'calendar'
    end

    it 'assigns issues to @issues' do
      Issue.stub(:all).and_return :issues
      get 'calendar'
      expect(assigns(:issues)).to eq :issues
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
