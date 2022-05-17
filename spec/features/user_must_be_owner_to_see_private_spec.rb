require 'rails_helper'

feature 'Only owner can see private tasks' do
  scenario 'Sucessfully' do
    user = create(:user)
    profile = create(:profile, user: user)
    other_user = create(:user)
    task = create(:task, user: other_user)
    login_as(user)

    visit task_path(task)

    expect(current_path).to eq root_path
  end
end
