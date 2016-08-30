class PlacesController < ApplicationController
  before_action :find_place, only: [ :show, :edit, :update, :destroy ]
  before_action :find_geocoder, only: [ :show, :update ]
  before_action :find_connection_meeting, only: [ :index, :show, :update ]

  def index
    @types = ["afterwork", "café", "lunch snack", "salad bar", "restaurant"]
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def show
    @availabilities = @place.order_dates_by_days
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to place_availabilities_path(@place)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @availabilities = @place.order_dates_by_days
    if current_user.status
      @place.update(place_params)
      if @place.save
        redirect_to partner_path(@user)
      else
        render :edit
      end
    else
      @meeting.place = @place
      if resa_params[:date] != "" && @place.available?(str_to_date(resa_params[:date]))
        @meeting.date = str_to_date(resa_params[:date])
        @meeting.save
        redirect_to connection_meeting_path(@connection, @meeting)
      else
        render :show
      end
    end
  end

  def destroy
    @place.destroy
    redirect_to partner_path(@user)
  end

  private

  def hash_geocoder(place_model)
    Gmaps4rails.build_markers(place_model) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "/places/map_box", locals: { place: place })
    end
  end

  def place_params
    params.require(:place).permit!
  end

  def resa_params
    params.permit!
  end

  def str_to_date(date)
    DateTime.strptime(date, '%m/%d/%Y %I:%M %p')
  end

  def find_place
    @place = Place.find(params[:id])
  end

  def find_geocoder
    @hash = hash_geocoder(@place)
  end

  def find_connection_meeting
    unless current_user.status
      @connection = Connection.find(params[:connection_id])
      @meeting = Meeting.find(params[:meeting_id])
    end
  end
end
