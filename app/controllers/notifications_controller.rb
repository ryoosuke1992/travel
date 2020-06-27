class NotificationsController < ApplicationController
  before_action :logged_in_user

  def index
    @notifications = current_user.notifications.order(created_at: :desc).paginate(page: params[:page], per_page: 4)
    current_user.update_attribute(:notification, false)
  end
end
