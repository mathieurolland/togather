class SkillsController < ApplicationController

  def index
    ids = categories_params[:categories]
    @categories = Category.where(id: ids)
    skills = Skill.where(category: ids)
    @listing_skills = {}
    @categories.each do |category|
      @listing_skills[category.name] = skills.select { |skill|  skill.category_id == category.id  }
    end
  end

  private

  def categories_params
    params.require(:id_categories).permit!
  end
end
