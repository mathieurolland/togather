class Meeting < ApplicationRecord
  belongs_to :connection
  belongs_to :place
  has_many :messages
  has_one :place, through: :user
  validates :date, presence: true
end
