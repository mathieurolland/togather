class AvailabilitiesController < ApplicationController
  before_action :defind_arrays, only: [ :index, :create, :edit, :update ]
  before_action :find_availability, only: [ :edit, :update, :destroy ]
  before_action :save_availability, only: [ :create, :update ]

  def index
  end

  def create
    if valid_form?
      redirect_to place_availabilities_path(@place)
    else
      render :index
    end
  end

  def edit
  end

  def update
    if valid_form?
      redirect_to place_availabilities_path(@place)
    else
      render :edit
    end
  end

  def destroy
    @availability.destroy
    redirect_to place_availabilities_path(@availability.place, @availability )
  end

  private

  def new_date_params
    params.require(:new_date).permit!
  end

  def defind_arrays
    @place = Place.find(params[:place_id])
    @days = ["Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    @minutes = ["00", "10", "20", "30", "40", "50"]
  end

  def find_availability
    @availability = Availability.find(params[:id])
  end

  def save_availability
    @p = new_date_params
    @max_time = Time.utc(2000, 1, 1, @p[:max_hour].to_i, @p[:max_minute].to_i )
    @min_time = Time.utc(2000, 1, 1, @p[:min_hour].to_i, @p[:min_minute].to_i )
    @availability = @place.availabilities.new(  max_day: @p[:max_day],
                                                min_day: @p[:min_day],
                                                max_time: @max_time,
                                                min_time: @min_time)
  end

  def valid_form?
    @days.index(@p[:max_day]) >= @days.index(@p[:min_day]) && @max_time > @min_time && @availability.save
  end
end


