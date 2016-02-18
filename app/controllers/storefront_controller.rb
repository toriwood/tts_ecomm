class StorefrontController < ApplicationController
  def all_items
  	@products = Product.all
  	@categories = Category.order('name ASC').all
  end

  def items_by_category
  end

  def items_by_price
  end
end
