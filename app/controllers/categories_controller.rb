class CategoriesController < ApplicationController
  def index
    @listing = Category.all
    @skill = Skill.new
  end
end
