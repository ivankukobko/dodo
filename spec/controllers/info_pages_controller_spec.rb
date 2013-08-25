require 'spec_helper'

describe InfoPagesController do

  describe "GET 'index'" do
    it "shows pages list" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'index'" do
    it "shows pages list" do
      page = create(:info_page)
      get :show, id: page.permalink
      response.should be_success
    end
  end

end
