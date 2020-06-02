class PlansController < ApplicationController
	before_action :logged_in_user, only: [:new, :index, :show, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	
	def new
		@plan = Plan.new
	end

	def create
		@plan = current_user.plans.new(plan_params)
		if @plan.save
			flash[:success] = "新規旅行が投稿されました"
			redirect_to root_path
		else
			render 'plans/new'
		end
	end
	
	private

	 def plan_params
		params.require(:plan).permit(:title, :date, :place, :meeting_place,
		:meeting_time, :content)
	 end

end
