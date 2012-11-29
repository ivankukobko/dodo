require 'spec_helper'

describe DashboardController do

  describe "GET 'index'" do
    it "returns http success" do
      user = create(:user)
      request.session[:user_id] = user.id
      get 'index'
      response.should be_success
    end
  end

end
