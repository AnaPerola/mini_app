require 'rails_helper'

feature 'User can edit Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    
    task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Board'
    click_on 'Edit Task'
    fill_in 'task[title]', with: 'Test #22'
    click_on 'Update Task'

    expect(page).to have_content('Task updated!')
    expect(Task.last.title).to eq('Test #22')
  end 

  scenario 'And must fill all fields' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Board'
    click_on 'Edit Task'
    fill_in 'task[title]', with: 'Test #22'
    fill_in 'task[description]', with: 'Descriotion #22'
    select 'medium', from: 'task[priority]'
    select 'complete', from: 'task[status]' 
    select 'Public', from: 'task[share]' 
    click_on 'Update Task'

    expect(page).to have_content('Task updated!')

    expect(Task.last.title).to eq('Test #22')
    expect(Task.last.description).to eq('Descriotion #22')
    expect(Task.last.priority).to eq('medium')
    expect(Task.last.status).to eq('complete')
    expect(Task.last.share).to eq(true)
  end
end
