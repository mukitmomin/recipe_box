class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  # => so @recipe is available to show edit update and destroy methods as an instance var
  def index
    # => show all recipes in descending order
    @recipe = Recipe.all.order("created_at DESC")
  end

  def show

  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to @recipe, notice: "Successfully created new recipe"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to(@recipe)
    else
      # render edit form if fail to save
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to root_path, notice: "Successfully deleted recipe"
  end

  private

  def find_recipe
    # the before_action method uses this to find the db entries, so we don't need to write code to find recipes for each Action
    @recipe = Recipe.find(params[:id])
  end

  # to prevent sql injection, by whitelisting attributes
  def recipe_params
    params.require(:recipe).permit(:title, :description, :image,
                                    ingredients_attributes: [:id, :name, :_destroy],
                                    directions_attributes: [:id, :step, :_destroy])
  end
end
