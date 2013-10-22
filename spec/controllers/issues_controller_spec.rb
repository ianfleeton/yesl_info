require 'spec_helper'

describe IssuesController do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user, organisation: organisation) }
  let(:trespasser) { FactoryGirl.create(:user) }

  # checks authorization
  context 'when trespassing' do
    before do
      controller.stub(:current_user).and_return(user)
    end
  end

  context 'when signed in as user' do
    before do
      controller.stub(:current_user).and_return(user)
    end

    describe 'GET new' do
      it 'renders' do
        get :new, organisation_id: organisation.id
        expect(response).to render_template :new
      end
    end

    describe 'POST create' do
      it "assigns the user's organisation to the issue" do
        post :create, issue: FactoryGirl.build(:issue, organisation_id: nil).attributes
        expect(assigns(:issue).organisation).to eq user.organisation
      end

      it "assigns the user as the issue's setter" do
        post :create, issue: FactoryGirl.build(:issue).attributes
        expect(assigns(:issue).setter).to eq user
      end
    end
  end

  context 'when signed in as admin' do
    before do
      controller.stub(:current_user).and_return(admin)
    end

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
  end
end
