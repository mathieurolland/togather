class Message < ApplicationRecord
  belongs_to :meeting
  belongs_to :user
  validates :content, presence: true
  validates :meeting, presence: true
end
