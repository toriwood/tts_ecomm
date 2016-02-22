class AdminController < ApplicationController
  def power
  	@users = User.all
  end
end
