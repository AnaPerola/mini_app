class Profile < ApplicationRecord
  validates :nickname, uniqueness: {message: 'Nickname Taken! Chose Another one'}
  validates :nickname, length: {minimum: 4, message: 'Nickname too short, Minimum of 4 characters'}
  validates :nickname, length: {maximum: 20, message: 'Nickname too long, Maximum of 20 characters'}
  validates :bio, presence: {message: 'Bio cannot be blank'}
  validates :bio, length: {maximum: 500, message: 'Bio Max Length is 500 characters'}
  
  belongs_to :user
  has_one_attached :avatar

end
