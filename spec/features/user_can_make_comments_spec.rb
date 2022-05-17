require 'rails_helper'

feature 'User can make comments' do
  scenario 'Successfully' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)
    fill_in 'Comment', with: 'Test Comment'
    click_on 'Post Comment'

    expect(page).to have_content('Comment Added!')
    expect(page).to have_content('Test Comment')

  end

  scenario 'And can make multiple comments on same Task' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)
    fill_in 'Comment', with: 'First Comment'
    click_on 'Post Comment'
    fill_in 'Comment', with: 'Second Comment'
    click_on 'Post Comment'

    expect(page).to have_content('First Comment')
    expect(page).to have_content('Second Comment')

  end

  scenario 'And comment can\'t be blank' do 
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    login_as(user)

    visit task_path(task)
    fill_in 'Comment', with: ''
    click_on 'Post Comment'

    expect(page).to have_content('Comment body can\'t be blank')
    expect(page).not_to have_content('Test Comment')

  end

  scenario 'And can go to the user profile if public' do
    user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on "@#{user.profile.nickname}"

    expect(current_path).to eq profile_path(user) 

  end

  scenario 'And get a \'Private Profile\' page if profile private' do
    user = create(:user)
    other_user = create(:user)
    create(:profile, user: user, share: false)
    create(:profile, user: other_user, share: false)
    task = create(:task, user: user)
    comment = create(:comment, user: other_user, task: task)
    login_as(user)

    visit task_path(task)
    click_on "@#{other_user.profile.nickname}"

    expect(current_path).not_to eq profile_path(other_user)
    expect(page).to have_content("@#{other_user.profile.nickname} Profile is Private")

  end

  scenario 'And can see all owned comments' do
    user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    other_comment = create(:comment, user: user, task: task)
    login_as(user)

    visit root_path
    click_on 'My Comments'

    expect(page).to have_content(comment.body)
    expect(page).to have_content(other_comment.body) 

  end

  scenario 'And can Delete a Comment' do
    pending("Can't make Capybara click on Pop Ups")
    user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on 'Delete'
    click_button 'Ok'
    
    expect(page).not_to have_content(comment.body)

  end

  scenario 'And must be owner to Delete a Comment' do 
    user = create(:user)
    other_user = create(:user)
    create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    login_as(other_user)

    visit task_path(task)

    expect(page).not_to have_css('button', text: 'Delete')
  end

  scenario 'And can sort Comments By New' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    old_comment = create(:comment, user: user, task: task)
    new_comment = create(:comment, user: user, task: task)
    login_as(user)

    visit profile_comments_path(user.profile)
    click_on 'Newest'

    new_comment.body.should appear_before(old_comment.body)

  end

  scenario 'And can sort Comments by Old' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    old_comment = create(:comment, user: user, task: task)
    new_comment = create(:comment, user: user, task: task)
    login_as(user)

    visit profile_comments_path(user.profile)
    find('a', text: 'Oldest').click


    old_comment.body.should appear_before(new_comment.body)

  end 

  scenario 'And can sort comments on task page by Newest' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    oldest_comment = create(:comment, user: user, task: task)
    newest_comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on 'Newest'

    newest_comment.body.should appear_before(oldest_comment.body)

  end

  scenario 'And can sort comments on task page by Oldest' do
    user = create(:user)
    create(:profile, user: user)
    task = create(:task, user: user)
    oldest_comment = create(:comment, user: user, task: task)
    newest_comment = create(:comment, user: user, task: task)
    login_as(user)

    visit task_path(task)
    click_on 'Oldest'

    oldest_comment.body.should appear_before(newest_comment.body)

  end

  scenario 'And must be Loged in to see all Comments page' do
    user = create(:user)
    profile = create(:profile, user: user, share: true)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    other_comment = create(:comment, user: user, task: task)

    visit profile_comments_path(profile)

    expect(current_path).to eq root_path

  end

  scenario 'And profile must be public to see all Comments page' do
    user = create(:user)
    other_user = create(:user)
    profile = create(:profile, user: user, share: false)
    other_profile = create(:profile, user: other_user)
    task = create(:task, user: user)
    comment = create(:comment, user: user, task: task)
    other_comment = create(:comment, user: user, task: task)
    login_as(other_user)

    visit profile_comments_path(profile)

    expect(current_path).to eq root_path

  end
end
