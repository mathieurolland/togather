class Place < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  belongs_to :user
  has_many :meetings
  has_many :availabilities
  has_attachment :photo


  validates :name, presence: true
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :description, presence: true
  validates :phone_number, presence: true
  validates :phone_number, uniqueness: true
  validates :type_partner, presence: true

  def order_dates_by_days
    days = ["Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday", "Sunday"]
    order_dates = {}
    days.each { |day| order_dates[day] = [] }
    self.availabilities.each do |a|
      days[days.index(a.min_day)..days.index(a.max_day)].each do |day|
        order_dates[day] << { min_time: a.min_time, max_time: a.max_time }
      end
    end
    order_dates.each { |day, arr| order_dates[day] = arr.sort_by { |hours| hours[:min_time] } }
    order_dates
  end

  def available?(date)
    days = ["Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday", "Sunday"]
    availanilities = self.order_dates_by_days
    t = DateTime.strptime(date.strftime("%I:%M%p"), '%I:%M %p')
    day = days[date.wday - 1]
    availanilities[day].each do |a|
      t_min = DateTime.strptime(a[:min_time].strftime("%I:%M%p"), '%I:%M %p')
      t_max = DateTime.strptime(a[:max_time].strftime("%I:%M%p"), '%I:%M %p')
      if t >= t_min && t <= t_max
        return true
      end
    end
    false
  end
end
