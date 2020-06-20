class FavoritesController < ApplicationController
	before_action :logged_in_user

	def index
		@favorites = current_user.favorites
	end

  def create
    @plan = Plan.find(params[:plan_id])
    @user = @plan.user
    current_user.favorite(@plan)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
	end

	if @user != current_user
      @user.notifications.create(plan_id: @plan.id, variety: 1,
                                 from_user_id: current_user.id)
      @user.update_attribute(:notification, true)
    end
  end

  def destroy
	@plan = Plan.find(params[:plan_id])
	current_user.favorites.find_by(plan_id: @plan.id).destroy
	respond_to do |format|
		format.html { redirect_to request.referrer || root_url }
		format.js
	end
  end
end