class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
	
	if @comment.errors.any?
		flash[:alert] = "Please make sure that neither field is empty."
	end
	redirect_to post_path(@post)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end