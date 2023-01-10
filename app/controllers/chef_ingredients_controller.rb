class ChefIngredientsController < ApplicationController
  def index
    @chef = Chef.find(params[:chef_id])
    @ingredients = @chef.ingredients.distinct
  end

end