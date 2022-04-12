require 'rails_helper'

feature 'User can Update profile' do
  scenario 'Bio' do 
    user = create(:user)
    create(:profile, user: user) 
    login_as(user)

    visit root_path 
    click_on 'My Profile'
    click_on 'Edit Info'

    fill_in 'Your Bio:', with: 'Another Bio'
    click_on 'Update Profile'
    user.reload

    expect(user.profile.bio).to eq 'Another Bio' 
  end

  scenario 'and Profile Picture' do
    user = create(:user)
    create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'My Profile' 
    click_on 'Edit Info'
    attach_file('Your Profile Picture', 'spec/support/assets/test-update.png')

    click_on 'Update Profile'
    user.reload

    expect(user.profile.avatar.attached?).to eq true
  end

  scenario 'And must fill fields' do
    user = create(:user)
    create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'My Profile'
    click_on 'Edit Info'

    fill_in 'Your Bio:', with: ''
    click_on 'Update Profile'

    expect(page).to have_content('Bio cannot be blank')
  end
end
