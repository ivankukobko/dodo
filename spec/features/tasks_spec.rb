require 'spec_helper'

feature 'Tasks', %q{} do

  background do
    visit '/'
    @user = create(:user)
    sign_in @user.email, @user.password
  end

  scenario "Show user's unattached tasks" do
    @user.tasks.create([
      {title: 'My task 1'},
      {title: 'My task 2'},
      {title: 'My task 3'}
    ])

    project = @user.projects.create(
      {name: 'Project 1'}
    )

    project.tasks.create([
      {title: 'Project 1 - My task 1'},
      {title: 'Project 1 - My task 2'},
      {title: 'Project 1 - My task 3'}
    ])

    visit todo_items_path
    page.should have_content('My task 1')
    page.should have_content('My task 2')
    page.should have_content('My task 3')
    page.should_not have_content('Project 1 - My task 3')
  end

  scenario "Show user's unattached tasks" do
    @user.tasks.create([
      {title: 'My task 1'},
      {title: 'My task 2'},
      {title: 'My task 3'}
    ])

    visit todo_item_path(@user.tasks.last)

    page.should have_content('My task 1')
  end
end

