class Category < ApplicationRecord
  has_many :skills
  has_many :user_skills, through: :skills
  has_many :users, through: :user_skills
end
