class PlansController < ApplicationController
	before_action :logged_in_user, only: [:new, :index, :show, :edit, :update]
	before_action :correct_user,   only: [:edit, :update]
	
	def new
		@plan = Plan.new
	end

	def show
		@plan = Plan.find(params[:id])
	end

	def create
		@plan = current_user.plans.new(plan_params)
		if @plan.save
			flash[:success] = "新規旅行)が投稿されました"
			redirect_to @plan
		else
			render 'plans/new'
		end
	end

	def edit
		@plan = Plan.find(params[:id])
	end

	def update
		@plan = Plan.find(params[:id])
		if @plan.update_attributes(plan_params)
			flash[:success] = "旅行情報が更新されました"
			redirect_to @plan
		else
			render 'edit'
		end
	end
	
	private

	 def plan_params
		params.require(:plan).permit(:title, :date, :place, :meeting_place,
		:meeting_time, :content)
	 end

end
