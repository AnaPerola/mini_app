require 'rails_helper'

feature 'User creates a profile' do
  scenario '(root)And is redirected to profile creating page if doesn\'t have one' do
    user = create(:user)
    login_as(user)
    
    visit root_path

    expect(current_path).to eq new_profile_path
  end

  scenario 'And can\'t access new_task_path if doesn\'t have a profile' do
    user = create(:user)
    login_as(user)
    
    visit new_task_path

    expect(current_path).to eq new_profile_path
  end

  scenario 'Successfully' do
    user = create(:user)
    login_as(user)

    visit root_path
    fill_in 'Nickname:', with: 'Godot'
    fill_in 'Bio', with: 'A Personal Bio'
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Profile Created!')
    expect(Profile.last.nickname).to eq 'Godot'
    expect(Profile.last.bio).to eq 'A Personal Bio'
    expect(Profile.last.avatar.attached?).to eq true
  end

  scenario 'And Must have a Unique Nickname' do
    user = create(:user)
    other_user = create(:user)
    create(:profile, user: other_user, nickname: 'JoJoFan')
    login_as(user)

    visit root_path

    fill_in 'Nickname:', with: 'JoJoFan'
    fill_in 'Bio', with: 'A Personal Bio'
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Nickname Taken! Chose Another one')
    expect(user.profile).to eq nil
  end

  scenario 'And nickname Must have at least 5 characters' do
    user = create(:user)
    login_as(user)

    visit root_path

    fill_in 'Nickname:', with: ''
    fill_in 'Bio', with: 'A Personal Bio'
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Nickname too short, Minimum of 4 characters')
    expect(user.profile).to eq nil
  end

  scenario 'And nickname Must have less than 20 characters' do
    user = create(:user)
    login_as(user)

    visit root_path

    fill_in 'Nickname:', with: "A" * 21
    fill_in 'Bio', with: 'A Personal Bio'
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Nickname too long, Maximum of 20 characters')
    expect(user.profile).to eq nil
  end


  scenario 'And bio Cannot be empty' do
    user = create(:user)
    login_as(user)

    visit root_path

    fill_in 'Nickname:', with: 'Test123'
    fill_in 'Bio', with: ''
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Bio cannot be blank')
    expect(user.profile).to eq nil
  end

  scenario 'And bio Cannot have more than 500 characters' do
    user = create(:user)
    login_as(user)

    visit root_path

    fill_in 'Nickname:', with: 'Test123'
    fill_in 'Bio', with: "A" * 501
    attach_file('Your Profile Picture', 'spec/support/assets/test-image.png')
    click_on 'Create Profile'

    expect(page).to have_content('Bio Max Length is 500 characters')
    expect(user.profile).to eq nil
  end 

end
