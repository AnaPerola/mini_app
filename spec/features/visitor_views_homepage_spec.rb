require 'rails_helper'

feature 'Visitor Views homepage' do
  scenario 'Sucessfully' do
    visit root_path

    expect(page).to have_css('h1', text: 'Task Manager App')
    expect(current_path).to eq root_path
  end 
end
