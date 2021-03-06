class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update, :destroy, :followings, :followers]
  before_action :current_user, only:[:edit, :update, :destroy]
  
  def index
    @user = User.find_by(id: params[:id])
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to login_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'User は正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'User は更新されませんでした'
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  
  
  def likes
    @user = User.find(params[:id])
    @posts = @user.likes.page(params[:page])
    counts(@user)
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = 'ユーザー情報を削除しました。'
    redirect_to root_url
  end
  
  
  private
  
  def correct_user
    @user = User.find_by(id: params[:id])
    unless @user == current_user
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :prof, :image, :image_cache, :remove_image)
  end
end
