require 'rails_helper'

feature 'User can view public tasks in Homepage' do
  scenario 'Sucessfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, share: true)
    second_task = create(:task, user: user, share: true)
    third_task = create(:task, user: user, share: true)
    fourth_task = create(:task, user: user, share: false)
    login_as(user)

    visit root_path

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title)
    expect(page).to have_content(third_task.title)
    expect(page).not_to have_content(fourth_task.title)

  end
end
