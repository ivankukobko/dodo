require 'spec_helper'

describe HomeController do

  context "Unauthorized user" do
    describe "GET 'index'" do
      it "redirects unauthorized users to login page" do
        get 'index'
        response.status.should eql(302)
      end
    end
  end

  context "Authorized user" do
    describe "GET" do
      it 'show home page for authorized user' do
        user = create(:user)
        request.session[:user_id] = user.id
        get :index
        response.should be_success
      end
    end
  end

end

