require 'rails_helper'

feature 'User can search for tasks' do 
  scenario 'And find one specific name' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user)
    second_task = create(:task, user: user)
    login_as(user)

    visit root_path
    fill_in 'Search Tasks:', with: first_task.title
    find('#search-btn').click

    expect(page).to have_content(first_task.title)
    expect(page).not_to have_content(second_task.title) 
  end

  scenario 'And find a partial name' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, title: 'ABCTask1', user: user, share: true)
    second_task = create(:task, title: 'ABCTask2', user: user, share: true)
    third_task = create(:task, user: user, share: true)
    login_as(user)

    visit root_path
    fill_in 'Search Tasks:', with: 'ABC'
    find('#search-btn').click

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title) 
    expect(page).not_to have_content(third_task.title) 
  end 

  scenario 'And can\'t find other users tasks' do
    user = create(:user)
    profile = create(:profile, user: user)
    other_user = create(:user)
    task = create(:task, user: other_user, title: 'Other User')
    login_as(user)

    visit root_path
    fill_in 'Search Tasks:', with: task.title
    find('#search-btn').click

    expect(page).to have_content('0 Results Found')
  end
end
