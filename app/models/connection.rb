class Connection < ApplicationRecord
  belongs_to :guest, class_name: "User"
  belongs_to :host, class_name: "User"
  has_many :meetings
  has_many :messages, through: :meetings
end
