class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
  	current_item = line_items.find_by(product_id: product_id)
  	if current_item
  		current_item.quantity += 1
  	else
  		current_item = line_items.build(product_id: product_id)
  	end
  	current_item
  end

  def subtotal
  subtotal = 0
  	line_items.each do |item|
      subtotal += item.total_price
    end
    subtotal
  end

end
