require 'spec_helper'

describe ProjectsController do

  context "Owner's projects" do
    describe "GET index" do
      it 'shows projects list' do
        user = create(:user)
        request.session[:user_id] = user.id
        get :index
        response.should be_success
      end
    end
  end

end

