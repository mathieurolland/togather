class Message < ApplicationRecord
  sync :all
  belongs_to :meeting
  belongs_to :user
  validates :content, presence: true
  validates :meeting, presence: true
end
