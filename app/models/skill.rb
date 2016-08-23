class Skill < ApplicationRecord
  belongs_to :category
  has_many :user_skills
  validates :name, presence: true
end
