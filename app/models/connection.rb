class Connection < ApplicationRecord
  belongs_to :guest, class_name: "User"
  belongs_to :host, class_name: "User"
  has_many :meetings
  has_many :messages, through: :meetings
  validates :status, presence: true
  validates :guest, uniqueness: { scope: :host }

  def score
    ((self.guest.skills & self.host.skills).count * 1.0 / (self.guest.skills.count + self.host.skills.count) * 20).to_i
  end


end
