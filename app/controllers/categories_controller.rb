class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def categorie_params
    params.require(:product).permit( :name, :photo)
  end

end
