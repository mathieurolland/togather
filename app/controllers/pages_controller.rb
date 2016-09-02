class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @array = ["https://static.pexels.com/photos/7075/people-office-group-team.jpg","https://static.pexels.com/photos/29642/pexels-photo-29642.jpg","http://thegrandeventscenter.com/wp-content/uploads/2015/11/meetings-left1.jpg","https://static.pexels.com/photos/154/people-apple-iphone-writing.jpg"]
  end

  def dashboard
    if current_user.photo
      current_user.create_suggestions
      @suggestions = current_user.suggestions
      @places = Place.where.not(latitude: nil, longitude: nil)
      @recommended_user = RecommendedUser.new
      home = current_user
      suggestions = []
      friend_friend_connections = []
      friends = []

      @real_connections = current_user.total_connected

      current_user.invited_connections.where(status: "connected").each do |connection_when_guest|
        friends << User.find(connection_when_guest.host_id)
      end

      current_user.hosted_connections.where(status: "connected").each do |connection_when_host|
        friends << User.find(connection_when_host.guest_id)
      end

      suggest = current_user.suggestions
      suggest.each do |s|
        suggestions << User.find(s.host_id)
      end

      @hashhome = hash_geocoder_home(home)
      @hashfriends = hash_geocoder_friends(friends)
      @hashsuggestions = hash_geocoder_suggestions(suggestions)
      @hashplaces = hash_geocoder_places(@places)
    else
      current_user.update(photo_url: "https://t3.ftcdn.net/jpg/00/53/51/66/160_F_53516657_zFxg5J7wKRaRmjn00ez578LuO8WuSOOH.jpg")
      godfather = RecommendedUser.find_by_email(current_user.email).user
      Connection.create!(status: "connected", guest: godfather, host: current_user)
      redirect_to categories_path
    end
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
      marker.lat friend.latitude
      marker.lng friend.longitude
      marker.infowindow render_to_string(partial: "map_box_friend", locals: { friend: friend })
    end
  end

  def hash_geocoder_suggestions(suggestions)
    Gmaps4rails.build_markers(suggestions) do |s, marker|
      marker.lat s.latitude
      marker.lng s.longitude
      marker.infowindow render_to_string(partial: "map_box_friend", locals: { friend: s })
    end
  end
end
