class UserSkillsController < ApplicationController

  def create
    ids = skills_params[:skills]
    Skill.where(id: ids).each do |skill|
      UserSkill.create( user: current_user, skill: skill )
    end
    redirect_to dashboard_path
  end

  def destroy
  end

  private
  def skills_params
    params.require(:id_skills).permit!
  end
end
