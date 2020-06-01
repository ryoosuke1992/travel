class PlansController < ApplicationController
	before_action :logged_in_user, only: [:new, :index, :show, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	
	def new
		@plan = Plan.new
	end
end
