require 'rails_helper'

feature 'User can Create Task' do
  scenario 'Successfully' do
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

  scenario 'And must be loged in' do
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

  scenario 'And Title must have more than 4 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'task[title]', with: 'Tes'
    fill_in 'task[description]', with: 'Test Description'
    select 'medium', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Create Task'
    
    expect(page).to have_content('Title too short, Minimum of 4 characters')
    expect(Task.last).to eq nil
  end

  scenario 'And Title must have less than 20 characters' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'task[title]', with: "T" * 21
    fill_in 'task[description]', with: 'Test Description'
    select 'medium', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Create Task'
    
    expect(page).to have_content('Title too long, Maximum of 20 characters')
    expect(Task.last).to eq nil
  end 

  scenario 'And Description Can\'t be blank' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Create a Task'
    fill_in 'task[title]', with: 'Test Task'
    fill_in 'task[description]', with: ''
    select 'medium', from: 'task[priority]'
    select 'incomplete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Create Task'
    
    expect(page).to have_content('Description can\'t be blank')
    expect(Task.last).to eq nil
  end
end
