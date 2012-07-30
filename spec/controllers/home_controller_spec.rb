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
      user = FactoryGirl.create(:user, email: 'che@guevara.com', password: '111')
      sign_in user.email, user.password
      get :index
      response.should be_success
    end
  end

end

