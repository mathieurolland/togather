class Category < ApplicationRecord
  has_many :skills
  has_many :user_skills, through: :skills
  has_many :users, through: :user_skills
  validates :name, presence: true

  def select_label
    "#{Category.first.name}"
  end

end
