class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new (comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = "コメントできませんでした"
      render post_path(@post)
    end
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end


  private
  
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
  
end

