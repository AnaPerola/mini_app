require 'rails_helper'

RSpec.describe Task, type: :model do

  describe 'Valid' do

    it 'Is created with default \'status\' value os 0' do
      expect(Task.new.status.to_i).to eq 0
    end
  
    it 'Is created with default priority of 0' do
      expect(Task.new.priority.to_i).to eq 0
    end

    it 'Is created with default share status nil' do
      expect(Task.new.share).to eq nil
    end

    it 'Validating title and description' do
      user = User.create(email:'test@email.com', password:'123456')
      task = Task.new(title:'Title test', description: 'Description test', user_id: 1)
      expect(task).to be_valid
    end

  end

  describe 'Invalid' do

    it 'Title cannot be less than 4 characters' do
      user = User.create(email:'test@email.com', password:'123456')
      task = Task.new(title:'T', description: 'Description test', user_id: 1)
      expect(task).to_not be_valid
    end

    it 'Title can\'t be more than 20 characters' do
      user = User.create(email:'test@email.com', password:'123456')
      task = Task.new(title:'Title test in progress', description: 'Description test', user_id: 1)
      expect(task).to_not be_valid
    end

    it 'Description can\'t be blank' do
      user = User.create(email:'test@email.com', password:'123456')
      task = Task.new(title:'Title test', description: '', user_id: 1)
      expect(task).to_not be_valid
    end

    it 'Description cannot be more than 280 characters' do
      user = User.create(email:'test@email.com', password:'123456')
      task = Task.new(title:'Title test', description: "T" * 281, user_id: 1)
      expect(task).to_not be_valid
    end

    it 'Should not create without user' do 
      task = Task.new(title:'Title test', description: 'Description test')
      expect(task).to_not be_valid
    end
  end
end

