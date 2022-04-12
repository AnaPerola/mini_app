class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile , dependent: :destroy 
  has_many :tasks
  has_many :comments, dependent: :destroy 
  has_many :pluses, dependent: :destroy 
  has_many :minuses, dependent: :destroy
end
