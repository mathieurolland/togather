class Place < ApplicationRecord
  belongs_to :user
  has_many :meetings
  validates :name, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :description, presence: true
  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :type, presence: true
end
