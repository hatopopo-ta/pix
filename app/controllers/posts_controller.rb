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
    @post = Post.find(params[:id])
    @comment = @post.comments.new
    #@comments = @post.comments
    @comments = @post.comments.includes(:user).all
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = 'Post は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Post は更新されませんでした'
      render :edit
    end
  end
  
  
  private

  def post_params
    # params.require(:post).permit(:content, :image)
    params.require(:post).permit(:content, :image, :image_cache, :remove_image)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
