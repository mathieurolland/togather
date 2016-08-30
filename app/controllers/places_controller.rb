class PlacesController < ApplicationController

  def index
    @types = ["afterwork", "café", "lunch snack", "salad bar", "restaurant"]
    @places = Place.all
    unless current_user.status
      @connection = Connection.find(params[:connection_id])
      @meeting = Meeting.find(params[:meeting_id])
    end
  end

  def new
    @place = Place.new
  end

  def show
    @place = Place.find(params[:id])
    @place.user = current_user
    @availabilities = @place.order_dates_by_days
    unless current_user.status
      @connection = Connection.find(params[:connection_id])
      @meeting = Meeting.find(params[:meeting_id])
    end

    @url = "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png"
    @hash = Gmaps4rails.build_markers(@place) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "/places/map_box", locals: { place: place })
      # icon: "#{view_context.image_path("place2.png") }"
      # marker.picture({
      #                 :url    => "#{view_context.image_path("place2.png") }",
      #                 :width  => "64",
      #                 :height => "64",
      #                 # :scaledWidth => "15", # Scaled width is half of the retina resolution; optional
      #                 # :scaledHeight => "11", # Scaled width is half of the retina resolution; optional
      #               })
    end
    # @hash.each do |marker|
    #   marker[:icon] = "#{view_context.image_path("place2.png") }"
    # end
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to place_availabilities_path(@place)
      #redirect_to partner_path(@user)
    else
      render :new
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    @availabilities = @place.order_dates_by_days
    if current_user.status
      @place.update(place_params)
      if @place.save
        redirect_to partner_path(@user)
      else
        render :edit
      end
    else
      @connection = Connection.find(params[:connection_id])
      @meeting = Meeting.find(params[:meeting_id])
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
    @place = Place.find(params[:id])
    @place.destroy
    redirect_to partner_path(@user)
  end

  private

  def place_params
    params.require(:place).permit!
  end

  def resa_params
    params.permit!
  end

  def str_to_date(date)
    DateTime.strptime(date, '%m/%d/%Y %I:%M %p')
  end
end
