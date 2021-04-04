class User < ApplicationRecord
  has_many :books, dependent: :destroy
  attachment :profile_image,destroy: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :name,presence: true,
  uniqueness: true,
            length: { minimum: 2,maximum: 20 }, uniqueness: true
  validates :introduction,
            length: { maximum: 50 }
end
