require 'spec_helper'
require 'shared_examples_for_controllers'

describe CommentsController do
  # checks authorization
  context 'when trespassing' do
    let(:trespasser) { FactoryGirl.create(:user) }

    before do
      controller.stub(:current_user).and_return(trespasser)
    end

    describe 'POST create' do
      let(:issue) { FactoryGirl.create(:issue) }
      let(:comment) { FactoryGirl.build(:comment, issue: issue) }

      it 'blocks access if organisation is different to issue' do
        post :create, comment: comment.attributes
        expect_unauthorized
      end
    end
  end

  context 'when admin' do
    before do
      controller.stub(:current_user).and_return FactoryGirl.create(:admin)
    end

    describe 'POST create' do
      let(:issue) { FactoryGirl.create(:issue) }
      let(:comment) { FactoryGirl.build(:comment, issue: issue) }

      it 'creates a comment' do
        expect {
          post :create, comment: comment.attributes
          issue.reload
        }.to change { issue.comments.count }
      end

      it 'redirects to the issue' do
        post :create, comment: comment.attributes
        expect(response).to redirect_to issue
      end

      it 'sets the user to the current user' do
        post :create, comment: comment.attributes
        expect(assigns(:comment).user).to eq controller.current_user
      end
    end
  end
end
