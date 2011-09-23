require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test "should create user" do
    post :create, :post => { :email => 'user3@mail.com', :password => '111', :password_confirmation => '111' }
    assert_response :success
  end
end
