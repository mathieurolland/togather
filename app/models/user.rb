class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :hosted_guys, class_name: 'connection', foreign_key: 'host_id'
  has_many :invited_guys, class_name: 'connection', foreign_key: 'guest_id'
  has_many :meetings, through: :connections
  has_many :messages
  has_many :user_skills
  has_many :places
end
