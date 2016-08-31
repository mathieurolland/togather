class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @array = ["https://static.pexels.com/photos/7075/people-office-group-team.jpg","https://static.pexels.com/photos/29642/pexels-photo-29642.jpg","http://thegrandeventscenter.com/wp-content/uploads/2015/11/meetings-left1.jpg","https://static.pexels.com/photos/154/people-apple-iphone-writing.jpg"]
  end

  def dashboard
    current_user.create_suggestions
    @suggestions = current_user.suggestions#.sample(5)
    @places = Place.where.not(latitude: nil, longitude: nil)
    home = current_user
    friends = current_user.invited_connections
    suggestions = current_user.hosted_connections
    @hashhome = hash_geocoder_home(home)
    @hashfriends = hash_geocoder_friends(friends)
    @hashsuggestions = hash_geocoder_suggestions(suggestions)
    @hashplaces = hash_geocoder_places(@places)
  end

  def partner
    @meetings = Meeting.all
    @places = current_user.places
    @hash = hash_geocoder_places(@place)
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

  def hash_geocoder_home(my_home)
    Gmaps4rails.build_markers(my_home) do |home, marker|
      marker.lat home.latitude
      marker.lng home.longitude
      marker.infowindow "My work place"
    end
  end

  def hash_geocoder_places(place_model)
    Gmaps4rails.build_markers(place_model) do |place, marker|
      marker.lat place.latitude
      marker.lng place.longitude
      marker.infowindow render_to_string(partial: "/places/map_box_place", locals: { place: place })
    end
  end

  def hash_geocoder_friends(friends)
    Gmaps4rails.build_markers(friends) do |friend, marker|
      f = User.find(friend.host_id)
      marker.lat f.latitude
      marker.lng f.longitude
      marker.infowindow render_to_string(partial: "map_box_friend", locals: { friend: f })
    end
  end

  def hash_geocoder_suggestions(suggestions)
    Gmaps4rails.build_markers(suggestions) do |suggestion, marker|
      s = User.find(suggestion.guest_id)
      marker.lat s.latitude
      marker.lng s.longitude
      marker.infowindow render_to_string(partial: "map_box_friend", locals: { friend: s })
    end
  end
end
