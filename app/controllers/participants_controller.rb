class ParticipantsController < ApplicationController
  before_action :logged_in_user

  def create
    @plan = Plan.find(params[:plan_id])
    @user = @plan.user
    current_user.participant(@plan)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @plan = Plan.find(params[:plan_id])
    Participant.find_by(plan_id: @plan.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
