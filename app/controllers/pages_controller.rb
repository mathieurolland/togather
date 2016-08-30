class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]
  def home
    @array = ["https://static.pexels.com/photos/7075/people-office-group-team.jpg","https://static.pexels.com/photos/29642/pexels-photo-29642.jpg","http://thegrandeventscenter.com/wp-content/uploads/2015/11/meetings-left1.jpg","https://static.pexels.com/photos/154/people-apple-iphone-writing.jpg"]
  end

  def dashboard
    current_user.create_suggestions
    @suggestions = current_user.suggestions#.sample(5)
    @places = Place.where.not(latitude: nil, longitude: nil)
    @hash = hash_geocoder(@place)
  end

  def partner
    @meetings = Meeting.all
    @places = current_user.places
    @hash = hash_geocoder(@place)
    @count_places = @places.count
    @count_meetings = current_user.count_meetings
  end

  def edit_skills
  end

  def update_skills
    current_user.skills.destroy_all
    ids = skills_params[:skill_ids]
    Skill.where(id: ids).each do |skill|
      UserSkill.create( user: current_user, skill: skill )
    end
    redirect_to dashboard_path
  end

  private
  def skills_params
    params.require(:user).permit!
  end

  def hash_geocoder(place_model)
    Gmaps4rails.build_markers(place_model) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "/places/map_box", locals: { place: place })
    end
  end
end
