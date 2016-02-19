class ApplicationController < ActionController::Base
	helper_method :categories

	def categories
		@categories = Category.order('name ASC').all
	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
