class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  has_many :meetings
  validates :name, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :description, presence: true
  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :type_partner, presence: true
end
