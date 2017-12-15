class CategoriesController < ApplicationController
  protect_from_forgery

  def index
    @categories = Category.all
  end

  def create
    @category = Category.new(category_params)
    if @category.save 
      render :show 
    else 
      render json: @category.errors.full_messages, status: 422
    end 
  end

  def destroy
    category = Category.find(params[:id])
    if category 
      category.destroy
      render json: ["Deleted #{category.name}"]
    else 
      render json: ["Category doesn't exist!"], status: 404
    end 
  end

  private 

  def category_params
    params.require(:category).permit(:name)
  end 

end
