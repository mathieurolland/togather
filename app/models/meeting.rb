class Meeting < ApplicationRecord
  belongs_to :connection
  belongs_to :place
  has_many :messages
end
