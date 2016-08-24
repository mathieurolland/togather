class RecommendedUser < ApplicationRecord
  belongs_to :user
  validates :email, presence: true
  validates_format_of :email,:with => Devise::email_regexp
  validates :email, uniqueness: true
end
