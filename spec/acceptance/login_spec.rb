require 'spec_helper'

feature 'Sign In', %q{
  As a registered user
  I want to sign in to DoDo
} do

  background do
    visit '/'
  end

  scenario "Successful Sign In" do
    user = create(:user)
    sign_in user.email, user.password
    current_path.should eql(root_path)
    page.should have_content(I18n.t('sessions.create.success'))
  end

  scenario "Unsuccessful Sign In" do
    sign_in 'hacker@getyou.com', 'badpassword'
    current_path.should eql(new_session_path)
    page.should have_content(I18n.t('sessions.create.error'))
  end
end

