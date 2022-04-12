require 'rails_helper'

feature 'User can view tasks in TaskBoard' do
  scenario 'ordered by date'do
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)

    first_task = create(:task, user: user, title: 'first')
    second_task = create(:task, user: user, title: 'second')

    visit root_path
    click_on 'Task Board'

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title)
  end

  scenario 'and only sees their own tasks'do
    user = create(:user)
    profile = create(:profile, user: user)
    other_user = create(:user, email: 'other@email.com')
    login_as(user)
    
    first_task = create(:task, user: user, title: 'first')
    second_task = create(:task, user: user, title: 'second')
    other_user_task = create(:task, user: other_user, title: 'other')

    visit root_path
    click_on 'Task Board'

    expect(page).to have_content(first_task.title)
    expect(page).to have_content(second_task.title)
    expect(page).not_to have_content(other_user_task.title)
  end

  scenario 'And can click on Task name to see task Page' do 
    user = create(:user)
    profile = create(:profile, user: user)
    login_as(user)
    
    first_task = create(:task, user: user, title: 'first')
    
    visit root_path
    click_on 'Task Board'
    click_on 'View Task'

    expect(current_path).to eq task_path(first_task)
  end

  scenario 'And Can Order by Priority (High to Low)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, title: 'first', priority: 20)
    second_task = create(:task, user: user, title: 'second', priority: 10)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Highest Priority'

    first_task.title.should appear_before(second_task.title)

  end

  scenario 'And Can Order by Priority (low to high)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, title: 'first', priority: 20)
    second_task = create(:task, user: user, title: 'second', priority: 10)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Lowest Priority'

    second_task.title.should appear_before(first_task.title) 
  end

  scenario 'And Can Order By newest' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, title: 'first', priority: 20)
    second_task = create(:task, user: user, title: 'second', priority: 10)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Lowest Priority'
    click_on 'Newest'

    first_task.title.should appear_before(second_task.title) 
  end

  scenario 'And Can Order by oldest' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, title: 'first', priority: 20)
    second_task = create(:task, user: user, title: 'second', priority: 10)
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Oldest'

    second_task.title.should appear_before(first_task.title) 
  end

  scenario 'And can Order By Status (Complete First)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, status: 10)
    second_task = create(:task, user: user) 
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Complete First'

    first_task.title.should appear_before(second_task.title) 
  end

  scenario 'And can Order By Status (Incomplete First)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task, user: user, status: 10)
    second_task = create(:task, user: user) 
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Incomplete First'

    second_task.title.should appear_before(first_task.title) 
  end 

  scenario 'And can Order by Title (Ascending)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task,title: 'A Task', user: user)
    second_task = create(:task, title: 'B Task', user: user) 
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Title(asc)'

    first_task.title.should appear_before(second_task.title) 
  end

  scenario 'And can Order by Title (Descending)' do
    user = create(:user)
    profile = create(:profile, user: user)
    first_task = create(:task,title: 'A Task', user: user)
    second_task = create(:task, title: 'B Task', user: user) 
    login_as(user)

    visit root_path
    click_on 'Task Board'
    click_on 'Title(des)'

    second_task.title.should appear_before(first_task.title) 
  end 
end
