class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @plan = Plan.find(params[:plan_id])
    @user = @plan.user
    @comment = @plan.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@plan.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
      if @user != current_user
        @user.notifications.create(plan_id: @plan.id, variety: 2,
                                   from_user_id: current_user.id,
                                   content: @comment.content)
        @user.update_attribute(:notification, true)
      end
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @plan = @comment.plan
    if current_user.id == @comment.user_id
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to plan_url(@plan)
  end
end
