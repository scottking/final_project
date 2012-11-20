class User < ActiveRecord::Base
  attr_accessible :email, :name, :password_digest, :remember_token
  
  has_many :boards
  has_many :advertisements
  has_many :payment_details
  
  validates :email, presence: true
  validates :name, presence: true
  
  
end
