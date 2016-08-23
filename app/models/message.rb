class Message < ApplicationRecord
  belongs_to :meeting
  validates :content, presence: true
end
