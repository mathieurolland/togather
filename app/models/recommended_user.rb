class RecommendedUser < ApplicationRecord
  belongs_to :user
  validates :email, presence: true
  validates :email, uniqueness: true
end
