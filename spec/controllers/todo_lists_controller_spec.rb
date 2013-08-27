require 'spec_helper'

describe TodoListsController do

  context "Owner's todo lists" do
    describe "GET index" do
      it 'shows lists' do
        user = create(:user)
        request.session[:user_id] = user.id
        get :index
        response.should be_success
      end
    end
  end

end


