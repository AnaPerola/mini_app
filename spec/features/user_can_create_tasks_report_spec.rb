require 'rails_helper'

feature 'User can Create Task Report' do
  scenario 'Successfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    first_task = create(:task, user: user, share: true)
    second_task = create(:task, user: user, share: true)
    third_task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Report'

    expect(page).to have_content(first_task.id)
    expect(page).to have_content(second_task.id)
    expect(page).to have_content(third_task.id)
  end

  scenario 'And export PDF' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    first_task = create(:task, user: user, share: true)
    second_task = create(:task, user: user, share: true)
    third_task = create(:task, user: user, share: true)

    visit root_path
    click_on 'Task Report'
    click_on 'Export PDF document'

    expect(page).to have_content(first_task.id)
  end
end