class ProductsController < ApplicationController
  protect_from_forgery

  def index
    @products = Product.all
  end

  def show 
    @product = Product.find(params[:id])
  end 

  def create
    # product creation doesn't require categories right away
    # add categories later on with add_categories method
    @product = Product.new(product_params)
    if @product.save
      render :show 
    else 
      render json: @product.errors.full_messages, status: 422
    end 
  end

  def destroy
    product = Product.find(params[:id])
    if product 
      product.destroy 
      render json: ["Deleted #{product.name}!"]
    else 
      render json: ["Product doesn't exist"], status: 404
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      render :show
    else 
      render json: @product.errors.full_messages, status: 422
    end 
  end

  def add_categories
    # look for product_categories in params, if it exist and a product id is also provided
    # we will proceed into adding categories to the product
    category_ids = params[:product_categories]
    product_id = params[:id]

    if category_ids && product_id
      errors = []
      # Add product categories one by one 
      category_ids.each do |category_id|
        product_category = ProductCategory.new(product_id: product_id, 
                                               category_id: category_id)
        if !product_category.save 
          errors << "Error at category_id:#{category_id}, #{product_category.errors.full_messages}"
        end 
      end 

      handle_add_categories_error(errors)

    else
      render json: ["No Catgories or product provided to add"], status: 422
    end 
  end 

  def handle_add_categories_error(errors)
    # error handling for adding categories 
    if errors.empty?
      product = Product.find(product_id)
      categories = product.categories.map {|category| category.name }
      render json: ["Sucessfully put #{product.name} into #{categories} categories"]
    else 
      render json: errors, status: 422
    end 
  end 

  private

  def product_params
    params.require(:product).permit(:name,
                                    :price,
                                    :weight)
  end 

end
