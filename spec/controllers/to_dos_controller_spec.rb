require 'spec_helper'

describe ToDosController do
  before { signed_in_as_admin }

  describe 'POST create' do
    it 'allows only whitelisted attributes to be set' do
      post 'create', { to_do: ToDo.new.attributes }
      controller.send(:to_do_params).keys.should eq(['assignee_id', 'date_due', 'details',
        'estimated_time', 'organisation_id', 'priority', 'setter_id', 'title'])
    end
  end

  describe 'GET calendar' do
    it 'finds all to-dos' do
      ToDo.should_receive(:all)
      get 'calendar'
    end

    it 'assigns to-dos to @to_dos' do
      ToDo.stub(:all).and_return :to_dos
      get 'calendar'
      expect(assigns(:to_dos)).to eq :to_dos
    end
  end

  def signed_in_as_admin
    controller.stub(:admin?).and_return(true)
  end
end
