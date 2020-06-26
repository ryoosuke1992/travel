class StaticPagesController < ApplicationController
  def home
    @plans = Plan.all.order(created_at: :desc).paginate(page: params[:page], per_page: 9)
    @users = User.all
    @search = Plan.ransack(params[:q])
    @result = @search.result
  end
end
