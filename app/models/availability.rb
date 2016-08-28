class Availability < ApplicationRecord
  belongs_to :place
  validates :min_day, presence: true
  validates :max_day, presence: true
  validates :min_time, presence: true
  validates :max_time, presence: true
  # faire que la date de fin et plus grande que la date de début

  # def self.convert_str_to_dates(params)
  #   str_date = "#{params[:min_day][0..2]}, 01 Jan 2001 "
  #   str_hour = "#{params[:min_hour]}:#{params[:min_minute]}:00 GMT"
  #   min_date = DateTime.httpdate(str_date + str_hour)

  #   str_date = "#{params[:max_day][0..2]}, 01 Jan 2001 "
  #   str_hour = "#{params[:max_hour]}:#{params[:max_minute]}:00 GMT"
  #   max_date = DateTime.httpdate(str_date + str_hour)
  #   {min_date: min_date, max_date: max_date}
  # end

end
