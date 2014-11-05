require 'rails_helper'
require 'shared_examples_for_controllers'

describe IssuesController do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user, organisation: organisation) }
  let(:issue) { FactoryGirl.build(:issue, organisation: organisation) }

  # checks authorization
  context 'when trespassing' do
    let(:trespasser) { FactoryGirl.create(:user) }

    before do
      allow(controller).to receive(:current_user).and_return(trespasser)
    end

    describe 'GET show' do
      before { issue.save }

      it 'blocks access for different organisation' do
        get :show, id: issue.id
        expect_unauthorized
      end
    end

    describe 'GET edit' do
      before { issue.save }

      it 'blocks access if organisation is different' do
        get :edit, id: issue.id
        expect_unauthorized
      end
    end

    describe 'PATCH update' do
      before { issue.save }

      it 'blocks access if organisation is different' do
        patch :update, id: issue.id, issue: issue.attributes
        expect_unauthorized
      end
    end

    describe 'POST reopen' do
      before { issue.save }

      it 'blocks access if organisation is different' do
        post :reopen, id: issue.id, comment: 'Whatever'
        expect_unauthorized
      end
    end

    describe 'POST resolve' do
      before { issue.save }

      it 'blocks access if organisation is different' do
        post :resolve, id: issue.id, comment: 'Whatever'
        expect_unauthorized
      end
    end
  end

  context 'when signed in as user' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
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
      allow(controller).to receive(:current_user).and_return(admin)
    end

    describe 'GET show' do
      before { issue.save }

      it 'finds the issue' do
        get :show, id: issue.id
        expect(assigns(:issue)).to eq issue
      end
    end

    describe 'POST create' do
      it 'allows only whitelisted attributes to be set' do
        post 'create', { issue: Issue.new.attributes }
        expect(controller.send(:issue_params).keys).to eq(['assignee_id', 'date_due', 'details',
          'estimated_time', 'organisation_id', 'priority', 'setter_id', 'title'])
      end
    end

    describe 'PATCH update' do
      def patch_update
        issue.save!
        patch :update, id: issue.id, issue: issue.attributes
      end

      it 'redirects to the issue' do
        patch_update
        expect(response).to redirect_to(issue_path(issue))
      end
    end

    describe 'GET calendar' do
      it 'finds all issues' do
        expect(Issue).to receive(:all)
        get 'calendar'
      end

      it 'assigns issues to @issues' do
        allow(Issue).to receive(:all).and_return :issues
        get 'calendar'
        expect(assigns(:issues)).to eq :issues
      end
    end

    describe 'POST reopen' do
      before do
        issue.completed = true
        issue.save
      end

      it 'reopens the issue' do
        post :reopen, id: issue.id, comment: 'Broken'
        issue.reload
        expect(issue.completed).to be_falsey
      end

      it 'redirects to the issue' do
        post :reopen, id: issue.id, comment: 'Broken'
        expect(response).to redirect_to issue
      end

      it 'adds a comments on the issue' do
        post :reopen, id: issue.id, comment: 'Broken'
        comment = issue.comments.last
        expect(comment.comment.include?('* reopened the issue')).to be_truthy
        expect(comment.comment.include?('Broken')).to be_truthy
        expect(comment.user).to eq admin
      end
    end

    describe 'POST resolve' do
      before do
        issue.completed = false
        issue.save
      end

      it 'closes the issue' do
        post :resolve, id: issue.id, comment: 'Sorted'
        issue.reload
        expect(issue.completed).to be_truthy
      end

      it 'redirects to the issue' do
        post :resolve, id: issue.id, comment: 'Sorted'
        expect(response).to redirect_to issue
      end

      it 'adds a comments on the issue' do
        post :resolve, id: issue.id, comment: 'Sorted'
        comment = issue.comments.last
        expect(comment.comment.include?('* changed status to resolved')).to be_truthy
        expect(comment.comment.include?('Sorted')).to be_truthy
        expect(comment.user).to eq admin
      end
    end
  end
end
