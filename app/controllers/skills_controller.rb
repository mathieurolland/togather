class SkillsController < ApplicationController

  def index
    ids = categories_params[:categories]
    Skill.where(category: ids)
  end

  private

  def categories_params
    params.require(:id_categories).permit!
  end
end

 #<ActionController::Parameters {"utf8"=>"✓", "id_categories"=><ActionController::Parameters {"categories"=>["", "1", "2"]} permitted: false>, "commit"=>"submit", "controller"=>"skills", "action"=>"index"} permitted: false>
