require 'spec_helper'

feature 'Home page', %q{} do

  background do
    visit '/'
    @user = create(:user)
    sign_in @user.email, @user.password
  end

  scenario "Redirect to home page after log in" do
    current_path.should eql(root_path)
  end

  scenario "Show proper elements" do
    page.should have_content('Projects')
    page.should have_content('Tasks')
    page.should have_content('Contacts')
  end

  scenario "Show user's projects list" do
    @user.projects.create([
      {name: 'My project 1'},
      {name: 'My project 2'},
      {name: 'My project 3'}
    ])
    visit root_path
    page.should have_content('My project 1')
    page.should have_content('My project 2')
    page.should have_content('My project 3')
  end

  scenario "Show user's unattached tasks" do
    @user.tasks.create([
      {title: 'My task 1'},
      {title: 'My task 2'},
      {title: 'My task 3'}
    ])
    visit root_path
    page.should have_content('My task 1')
    page.should have_content('My task 2')
    page.should have_content('My task 3')
  end
end

