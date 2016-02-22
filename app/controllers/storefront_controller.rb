class StorefrontController < ApplicationController
  def all_items
  	@products = Product.all
  	@categories = Category.order('name ASC').all
  end

  def items_by_category
  	@categories = Category.order('name ASC').all
  	@category = Category.find(params[:format])
  	@products = @category.products
  end

  def items_by_tag
    @products = Product.where(tag: params[:tag])
    @tag = params[:tag]
  end

end
