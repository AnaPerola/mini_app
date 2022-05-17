require 'rails_helper'

feature 'User can Delete Tasks' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Board'
    click_on 'Delete Task'

    expect(page).to have_content("Task successfully destroyed!")
  end

  scenario 'And Must be loged in' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Board'
    click_on 'Delete Task'

    expect(page).to have_content('Task successfully destroyed!')
  end 
end
