require 'rails_helper'

feature 'User can change shared status' do
  scenario 'When creating a task to true' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[description]', with: 'Test Description'
    select 'medium', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Create Task'

    expect(Task.last.share).to eq true 
  end

  scenario 'When creating a task to false' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[description]', with: 'Test Description'
    select 'medium', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Private', from: 'task[share]'
    click_on 'Create Task'

    expect(Task.last.share).to eq false 

  end

  scenario 'On edit page to true' do 
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Edit Task'

    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[description]', with: 'Test Description'
    select 'high', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Update Task' 

    expect(Task.last.share).to eq true 
  end

  scenario  'On edit page to false' do 
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Edit Task'

    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[description]', with: 'Test Description'
    select 'high', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Private', from: 'task[share]' 
    click_on 'Update Task'

    expect(Task.last.share).to eq false 
  end 

  scenario 'And can edit on show page(Public to Private)' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, share: true)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'View Task'
    select 'Private', from: 'Change Privacy:'
    click_on 'Change Setting'

    expect(page).to have_content('This Task is Private')
  end

  scenario 'And can edit on show page(Private to Public)' do
    user = create(:user)
    profile = create(:profile, user: user)
    task = create(:task, user: user, share: true)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'View Task'
    select 'Private', from: 'Change Privacy:'
    click_on 'Change Setting'

    expect(page).to have_content('This Task is Private')
  end

end
