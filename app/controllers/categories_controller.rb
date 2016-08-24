class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @skill = Skill.new
  end
end
