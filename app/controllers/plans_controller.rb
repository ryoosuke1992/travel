class PlansController < ApplicationController
	before_action :logged_in_user, only: [:new, :index, :show, :edit, :update]
	before_action :current_user,   only: [:edit, :update]
	
	def new
		@plan = Plan.new
	end

	def show
		@plan = Plan.find(params[:id])
		@comment = Comment.new
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

	def destroy
    @plan = Plan.find(params[:id])
    if current_user?(@plan.user)
      @plan.destroy
      flash[:success] = "料理が削除されました"
      redirect_to request.referrer == user_url(@plan.user) ? user_url(@plan.user) : root_url
    else
      flash[:danger] = "他人の料理は削除できません"
      redirect_to root_url
    end
  end
	
	private

	 def plan_params
		params.require(:plan).permit(:title, :date, :place, :meeting_place,
		:meeting_time, :content,:image)
	 end

end