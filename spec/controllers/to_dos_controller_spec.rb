require 'spec_helper'

describe ToDosController do
  describe 'POST create' do
    it 'allows only whitelisted attributes to be set' do
      post 'create', { to_do: ToDo.new.attributes }
      controller.send(:to_do_params).keys.should eq(['assignee_id', 'date_due', 'details',
        'estimated_time', 'organisation_id', 'priority', 'setter_id', 'title'])
    end
  end
end
