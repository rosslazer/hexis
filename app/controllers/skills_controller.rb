class SkillsController < ApplicationController



	def new
		@user = User.find(params[:id])
  		@reviews = Array.new(3) { @user.reviews.build }
	end

	def create

	user = User.find(params[:id])

  @reviews = Review.create(params[:reviews])
  # Some more logic for validating the parameters passed in
	end


end
