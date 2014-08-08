require 'rails_helper'

describe OrganisationsController do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:trespasser) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user, organisation: organisation) }

  describe 'GET show' do
    it 'renders show_admin for admin' do
      controller.stub(:current_user).and_return admin
      get :show, id: organisation.id
      expect(response).to render_template 'organisations/show_admin'
    end

    it 'renders show for external users belonging to the organisation' do
      controller.stub(:current_user).and_return user
      get :show, id: organisation.id
      expect(response).to render_template 'organisations/show'
    end

    it 'requires a user' do
      controller.stub(:current_user).and_return nil
      get :show, id: organisation.id
      expect(response).to redirect_to new_session_path
    end

    it 'requires a user from the same organisation' do
      controller.stub(:current_user).and_return trespasser
      get :show, id: organisation.id
      expect(response).to redirect_to new_session_path
    end
  end

  describe 'POST unwatch' do
    context 'as admin' do
      before { controller.stub(:current_user).and_return admin }

      it 'redirects to the organisation' do
        post :unwatch, id: organisation.id
        expect(response).to redirect_to organisation
      end
    end
  end

  describe 'POST watch' do
    context 'as admin' do
      before { controller.stub(:current_user).and_return admin }

      it 'redirects to the organisation' do
        post :watch, id: organisation.id
        expect(response).to redirect_to organisation
      end
    end
  end

  describe 'GET new_timesheet_entry' do
    context 'as admin' do
      before { controller.stub(:current_user).and_return admin }

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
end
