class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.all.order(created_at: :desc)
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.username = current_user.name
    @comment.post_id = params[:post_id]
    if @comment.save
      redirect_to post_path(@comment.post), notice: "Comment was successfully created." 
      else
      redirect_to post_path(@comment.post), notice: "Comment was not created."
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@comment.post), notice: "Comment was successfully destroyed." 
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end
