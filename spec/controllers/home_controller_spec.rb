require 'spec_helper'

describe HomeController do
  before { controller.stub(:admin?).and_return(true) }

  describe 'GET index' do
    context 'with home content set' do
      before do
        NotePad.should_receive(:find_by)
          .with(title: 'Home Content')
          .and_return(mock_model(NotePad, content: 'Welcome'))
      end

      it 'finds home content and assigns to @home_content' do
        get 'index'
        expect(assigns(:home_content)).to eq 'Welcome'
      end
    end

    context 'with no home content' do
      before { NotePad.stub(:find_by).and_return(nil) }

      it 'sets @home_content to an empty string' do
        get 'index'
        expect(assigns(:home_content)).to eq ''
      end
    end
  end
end
