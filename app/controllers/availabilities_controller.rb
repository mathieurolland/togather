class AvailabilitiesController < ApplicationController

  def index
    @place = Place.find(params[:place_id])
    @availabilities = Availability.where(place: @place)
    @days = ["Monday", "Tuesday", "Wenesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @hours = ["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    @minutes = ["00", "10", "20", "30", "40", "50"]
  end

  def new
  end

  def create
    @place = Place.find(params[:place_id])
    new_dates = Availability.convert_str_to_dates(new_date_params)
    @availability = @place.availabilities.new(new_dates)
    @availability.save
    redirect_to place_availabilities_path(@place)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def new_date_params
    params.require(:new_date).permit!
  end

end
