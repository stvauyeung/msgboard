class User < ActiveRecord::Base
	has_many :posts
  has_many :comments
  
  has_secure_password
  validates :password, presence: true, on: :create

  validates :username, uniqueness: true
end