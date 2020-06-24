class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy,
  :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @plans = @user.plans.paginate(page: params[:page], per_page: 9) 
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Travelerにようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_update)
      flash[:success] = "プロフィールが更新されました"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーの削除をしました"
      redirect_to users_url
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "自分のアカウントを削除しました"
      redirect_to root_url
    else
      flash[:danger] = "アカウントを削除する権限がありません"
      redirect_to root_url
    end
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_params_update
      params.require(:user).permit(:name, :email, :introduction, :sex)
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:danger] = "このページへはアクセスできません"
        redirect_to(root_url)
      end
    end
end
