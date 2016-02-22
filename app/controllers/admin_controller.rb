class AdminController < ApplicationController
  def power
  	@users = User.all
  end

  def give_power
  	user = User.find(params[:id])
  	user.admin = true
  	user.save
  	redirect_to admin_path
  end

  def hog_power
  	user = User.find(params[:id])
  	user.admin = false
  	user.save
  	redirect_to admin_path
  end

end
