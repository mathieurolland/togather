class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @array = ["https://static.pexels.com/photos/7075/people-office-group-team.jpg","https://static.pexels.com/photos/29642/pexels-photo-29642.jpg","http://thegrandeventscenter.com/wp-content/uploads/2015/11/meetings-left1.jpg","https://static.pexels.com/photos/154/people-apple-iphone-writing.jpg"]
  end

  def dashboard
   current_user.create_suggestions
   @suggestions = current_user.suggestions
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
