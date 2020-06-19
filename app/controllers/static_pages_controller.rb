class StaticPagesController < ApplicationController
  def home
    @plans = Plan.all.paginate(page: params[:page], per_page: 9) 
  end
end
