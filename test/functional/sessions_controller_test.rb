require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should create session for correct login" do
    post :create, :user => { :email => 'user1@mail.com', :password => 'password'  }
    assert_response 302
  end

  test "should not create session for bad login" do
    post :create, :user => { :email => 'bad_user@mail.com', :password => 'password'  }
    assert_response :redirect
  end

end
