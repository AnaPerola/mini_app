require 'rails_helper'

feature 'User can login' do
  scenario 'Sucessfully'do
    user = create(:user)
    profile = create(:profile, user: user)

    visit root_path
    click_on 'Log In'
    within('form#new_user') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: '123456'
      click_on 'Log in'
    end

    expect(page).to have_content('Signed in successfully.') 
  end

  scenario 'and can create an Account' do
    visit root_path
    click_on 'Create Account'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(current_path).to eq new_profile_path
  end

  scenario 'and can log out' do
    user = create(:user) 
    profile = create(:profile, user: user)
    login_as(user)

    visit root_path
    click_on 'Log Out'

    expect(current_path).to eq root_path
    expect(page).to have_content('Signed out successfully') 
    expect(page).to have_content('Log In')
  end

end
