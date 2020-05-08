class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationships
  has_many :dogs
  has_many :likes, dependent: :destroy

  # Validations
  validates :name, :email, :password, :password_confirmation, presence: true
end
