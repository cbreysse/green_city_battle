class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :team
  has_many :participations
  has_many :events, through: :participations
  has_many :favorite_spots, dependent: :destroy
  has_many :spots, through: :favorite_spots
end
