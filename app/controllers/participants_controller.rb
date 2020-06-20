class ParticipantsController < ApplicationController
    def create
      @plan = Plan.find(params[:plan_id])
      if
        Participant.create(user_id: current_user.id, plan_id: @plan.id)
        redirect_to plans_path, notice: '旅行の申し込みが完了しました'
      else
        render 'show'
      end
    end
  end
