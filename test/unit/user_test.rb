require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should not create user without email" do
    user = User.new( :password => 'password', :password_confirmation => 'password' )
    assert !user.save
  end

  test "should not create user without password confirmation" do
    user = User.new( :email => 'user3@mail.com', :password => 'password' )
    assert !user.save
  end

  test "should not create user with same email" do
    user1 = User.new( :email => 'user3@mail.com', :password => 'password1', :password_confirmation => 'password1' )
    assert user1.save
    user2 = User.new( :email => 'user3@mail.com', :password => 'password2', :password_confirmation => 'password2')
    assert !user2.save
  end

end
