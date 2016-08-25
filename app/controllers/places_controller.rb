class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def show
    @place = Place.find(params[:id])
    @place.user = current_user
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    if @place.save
      redirect_to partner_path(@user)
    else
      render :new
    end
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
     @place = Place.find(params[:id])
     @place.update(place_params)
     if @place.save
      redirect_to partner_path(@user)
    else
      render :edit
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

  # def find
  #  @place = Place.find(params[:id])
  # end

end
