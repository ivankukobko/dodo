require 'spec_helper'

describe TodoItemsController do

  context "Owner's todo items" do
    describe "GET index" do
      it 'shows tasks list' do
        user = create(:user)
        request.session[:user_id] = user.id
        get :index
        response.should be_success
      end
    end
  end

end


