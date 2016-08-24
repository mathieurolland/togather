class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @suggestions = Connection.suggestions(current_user)
  end

  def edit_skills
  end

  def update_skills
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
