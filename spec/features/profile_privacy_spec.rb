require 'rails_helper'

feature 'A profile has a share status' do
  scenario 'and when true makes profile public' do
    user = create(:user)
    other_user = create(:user)
    create(:profile, user: user)
    profile = create(:profile, user: other_user, share: true)
    login_as(user)

    visit profile_path(profile)

    expect(current_path).to eq profile_path(profile)

  end

  scenario 'and when false makes profile private' do
    user = create(:user)
    other_user = create(:user)
    create(:profile, user: user)
    profile = create(:profile, user: other_user)
    login_as(user)

    visit profile_path(profile.id)

    expect(current_path).to eq private_page_profile_path(profile)

  end

  scenario 'and can change status from public to private' do
    user = create(:user)
    create(:profile, user: user)
    login_as(user)

    visit profile_path(user.profile.id)
    select 'Private' , from: 'Change Privacy:'
    click_on 'Change Setting'

    expect(user.profile.share).to eq false 
  end

  scenario 'and can change status from private to public' do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    visit profile_path(user.profile.id)
    select 'Public' , from: 'Change Privacy:'
    click_on 'Change Setting'
    profile.reload

    expect(user.profile.share).to eq true 

  end
end
