class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @array = ["https://static.pexels.com/photos/7075/people-office-group-team.jpg","https://static.pexels.com/photos/29642/pexels-photo-29642.jpg","http://thegrandeventscenter.com/wp-content/uploads/2015/11/meetings-left1.jpg","https://static.pexels.com/photos/154/people-apple-iphone-writing.jpg"]
  end

  def dashboard
   current_user.create_suggestions
   @suggestions = current_user.suggestions#.sample(5)
   @places = Place.where.not(latitude: nil, longitude: nil)
    @url = "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png"
    @hash = Gmaps4rails.build_markers(@places) do |place, marker|
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

  def partner
    @user = current_user
    @count_places = current_user.places.count

    i = 0
    @user.places.each do |place|
      place.meetings.each do |meeting|
        i += 1
      end
    end
    @count_meetings = i

    @meetings = Meeting.all
    @places = Place.all
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

end
