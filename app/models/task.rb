class Task < ApplicationRecord
  enum priority: {low: 0, medium: 10, high: 20}
  enum status: {incomplete: 0, complete: 10}

  validates :title, length: {minimum: 4, message: 'Title too short, Minimum of 4 characters'}
  validates :title, length: {maximum: 20, message: 'Title too long, Maximum of 20 characters'}
  validates :description, presence: true 
  validates :description, length: {maximum: 280, message: 'Description Max Length is 280 characters'} 

  belongs_to :user
  has_many :comments
end
