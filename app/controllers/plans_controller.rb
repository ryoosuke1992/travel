class PlansController < ApplicationController
  before_action :logged_in_user, only: [:new,  :show, :edit, :update]
  before_action :current_user,   only: [:edit, :update]

  def new
    @plan = Plan.new
  end

  def show
    @plan = Plan.find(params[:id])
    @random_plans = Plan.order("RANDOM()").limit(5)
    @comment = Comment.new
  end

  def create
	@plan = Plan.create(plan_params)
    if @plan.save
      flash[:success] = "新規旅行が投稿されました"
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
      flash[:success] = "企画が削除されました"
      redirect_to request.referrer == user_url(@plan.user) ? user_url(@plan.user) : root_url
    else
      flash[:danger] = "他人の企画は削除できません"
      redirect_to root_url
    end
  end

	private

	 def plan_params
		params.require(:plan).permit(:title, :date, :place, :meeting_place, :meeting_time, :content, :image).merge(user_id: current_user.id)
	end
end
