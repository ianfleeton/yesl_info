require 'rails_helper'

describe OrganisationsController do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:trespasser) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user, organisation: organisation) }

  describe 'GET show' do
    it 'renders show_admin for admin' do
      allow(controller).to receive(:current_user).and_return admin
      get :show, id: organisation.id
      expect(response).to render_template 'organisations/show_admin'
    end

    it 'renders show for external users belonging to the organisation' do
      allow(controller).to receive(:current_user).and_return user
      get :show, id: organisation.id
      expect(response).to render_template 'organisations/show'
    end

    it 'requires a user' do
      allow(controller).to receive(:current_user).and_return nil
      get :show, id: organisation.id
      expect(response).to redirect_to new_session_path
    end

    it 'requires a user from the same organisation' do
      allow(controller).to receive(:current_user).and_return trespasser
      get :show, id: organisation.id
      expect(response).to redirect_to new_session_path
    end
  end

  describe 'POST unwatch' do
    context 'as admin' do
      before { allow(controller).to receive(:current_user).and_return admin }

      it 'redirects to the organisation' do
        post :unwatch, id: organisation.id
        expect(response).to redirect_to organisation
      end
    end
  end

  describe 'POST watch' do
    context 'as admin' do
      before { allow(controller).to receive(:current_user).and_return admin }

      it 'redirects to the organisation' do
        post :watch, id: organisation.id
        expect(response).to redirect_to organisation
      end
    end
  end

  describe 'GET new_timesheet_entry' do
    context 'as admin' do
      before { allow(controller).to receive(:current_user).and_return admin }

      it 'sets @timesheet_entry belonging to the current user' do
        get :new_timesheet_entry, id: organisation.id
        expect(assigns(:timesheet_entry).user).to eq admin
      end

      it 'sets a @timesheet_entry belonging to the organisation' do
        get :new_timesheet_entry, id: organisation.id
        expect(assigns(:timesheet_entry).organisation).to eq organisation
      end
    end
  end

  describe 'POST archive' do
    let!(:organisation) { FactoryGirl.create(:organisation, archived: false) }

    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'archives the organisation' do
      post :archive, id: organisation.id
      expect(organisation.reload.archived?).to be_truthy
    end

    it 'redirects to the organisation' do
      post :archive, id: organisation.id
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'POST unarchive' do
    let!(:organisation) { FactoryGirl.create(:organisation, archived: true) }

    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'archives the organisation' do
      post :unarchive, id: organisation.id
      expect(organisation.reload.archived?).to be_falsey
    end

    it 'redirects to the organisation' do
      post :unarchive, id: organisation.id
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'POST add_tag' do
    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'adds a tag to the organisation' do
      post :add_tag, tag: 'tag', id: organisation.id
      expect(assigns(:organisation).reload.tag_list.first).to eq 'tag'
    end

    it 'sets a flash notice' do
      post :add_tag, tag: 'tag', id: organisation.id
      expect(flash[:notice]).to eq 'Tagged.'
    end

    it 'redirects to the organisation' do
      post :add_tag, tag: 'tag', id: organisation.id
      expect(response).to redirect_to(organisation)
    end
  end
end
