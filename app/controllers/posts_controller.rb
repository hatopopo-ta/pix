class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:new, :create, :destroy, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿しました。'
      redirect_to root_url
    else
      @posts = current_user.feed_posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = '投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def show
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
  end

  def update
  end
  
  
  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
