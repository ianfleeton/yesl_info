require 'rails_helper'

describe OrganisationsController do
  let(:organisation) { FactoryGirl.create(:organisation) }
  let(:admin) { FactoryGirl.create(:admin) }
  let(:trespasser) { FactoryGirl.create(:user) }
  let(:user) { FactoryGirl.create(:user, organisation: organisation) }

  describe 'GET show' do
    it 'renders show_admin for admin' do
      pending 'remove assert_template'
      allow(controller).to receive(:current_user).and_return admin
      get :show, params: { id: organisation.id }
      expect(response).to render_template 'organisations/show_admin'
    end

    it 'renders show for external users belonging to the organisation' do
      pending 'remove assert_template'
      allow(controller).to receive(:current_user).and_return user
      get :show, params: { id: organisation.id }
      expect(response).to render_template 'organisations/show'
    end

    it 'requires a user' do
      allow(controller).to receive(:current_user).and_return nil
      get :show, params: { id: organisation.id }
      expect(response).to redirect_to new_session_path
    end

    it 'requires a user from the same organisation' do
      allow(controller).to receive(:current_user).and_return trespasser
      get :show, params: { id: organisation.id }
      expect(response).to redirect_to new_session_path
    end
  end

  describe 'GET new_timesheet_entry' do
    context 'as admin' do
      before { allow(controller).to receive(:current_user).and_return admin }

      it 'sets @timesheet_entry belonging to the current user' do
        pending 'remove assigns'
        get :new_timesheet_entry, params: { id: organisation.id }
        expect(assigns(:timesheet_entry).user).to eq admin
      end

      it 'sets a @timesheet_entry belonging to the organisation' do
        pending 'remove assigns'
        get :new_timesheet_entry, params: { id: organisation.id }
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
      post :archive, params: {id: organisation.id}
      expect(organisation.reload.archived?).to be_truthy
    end

    it 'redirects to the organisation' do
      post :archive, params: {id: organisation.id}
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'POST unarchive' do
    let!(:organisation) { FactoryGirl.create(:organisation, archived: true) }

    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'archives the organisation' do
      post :unarchive, params: {id: organisation.id}
      expect(organisation.reload.archived?).to be_falsey
    end

    it 'redirects to the organisation' do
      post :unarchive, params: {id: organisation.id}
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'GET tags' do
    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'populates @tags with all tags' do
      pending 'remove assigns'
      organisation.tag_list << 'tag1'
      organisation.tag_list << 'tag2'
      organisation.save

      get :tags

      tag_names = assigns(:tags).map{|t| t.name}

      expect(tag_names).to include 'tag1'
      expect(tag_names).to include 'tag2'
    end
  end

  describe 'POST add_tag' do
    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'adds a tag to the organisation' do
      pending 'remove assigns'
      post :add_tag, params: { tag: 'tag', id: organisation.id }
      expect(assigns(:organisation).reload.tag_list.first).to eq 'tag'
    end

    it 'sets a flash notice' do
      post :add_tag, params: { tag: 'tag', id: organisation.id }
      expect(flash[:notice]).to eq 'Tagged.'
    end

    it 'redirects to the organisation' do
      post :add_tag, params: { tag: 'tag', id: organisation.id }
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'DELETE remove_tag' do
    before do
      allow(controller).to receive(:current_user).and_return admin
      organisation.tag_list << 'tag'
      organisation.save
    end

    it 'removes a tag from the organisation' do
      pending 'remove assigns'
      delete :remove_tag, params: { tag: 'tag', id: organisation.id }
      expect(assigns(:organisation).reload.tag_list.length).to eq 0
    end

    it 'sets a flash notice' do
      delete :remove_tag, params: { tag: 'tag', id: organisation.id }
      expect(flash[:notice]).to eq 'Tag removed.'
    end

    it 'redirects to the organisation' do
      delete :remove_tag, params: { tag: 'tag', id: organisation.id }
      expect(response).to redirect_to(organisation)
    end
  end

  describe 'GET tagged_with' do
    before do
      allow(controller).to receive(:current_user).and_return admin
    end

    it 'assigns @organisations with organisations tagged with params[:tag]' do
      pending 'remove assigns'
      o1 = FactoryGirl.build(:organisation)
      o1.tag_list << 'tag1'
      o1.save!
      o2 = FactoryGirl.build(:organisation)
      o2.tag_list << 'tag2'
      o2.save!

      get :tagged_with, params: { tag: 'tag1' }

      expect(assigns(:organisations)).to include(o1)
      expect(assigns(:organisations)).not_to include(o2)
    end

    it 'sets @tag to params[:tag]' do
      pending 'remove assigns'
      get :tagged_with, params: { tag: 'tag1' }
      expect(assigns(:tag)).to eq 'tag1'
    end
  end
end
