require 'spec_helper'

feature 'Sign In', %q{
  As a registered user
  I want to sign in to DoDo
} do
  background do
    visit '/'
  end
  scenario "Successful Sign In" do
    user = FactoryGirl.create(:user)
    fill_in 'Email', :with => user.email
    fill_in 'Password', :with => user.password
    click_button 'login'
    current_path.should == root_path
  end
  scenario "Unsuccessful Sign In" do
    fill_in 'Email', :with => 'hacker@getyou.com'
    fill_in 'Password', :with => 'badpassword'
    click_on 'login'
    current_path.should == new_session_path
    page.should have_content(I18n.t('sessions.create.error'))
  end
end

