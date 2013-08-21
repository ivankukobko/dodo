require 'spec_helper'

describe WorklogsController do

  context "Owner's worklogs" do
    describe "GET index" do
      it 'shows worklogs list' do
        user = create(:user)
        request.session[:user_id] = user.id
        get :index
        response.should be_success
      end
    end
  end

end

