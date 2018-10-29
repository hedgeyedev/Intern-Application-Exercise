class CommentsController < ApplicationController
  def show
  end

  def new
  	binding.pry
  	@post = Post.find(params[:post_id])
  	@comment = Comment.new
  end

  def create
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.new(comment_params)
  	@comment.user_id = current_user.id
  	@comment.save
  	redirect_to post_path(@post)	
  end

  def delete
  end


  private

  def comment_params
      params.require(:comment).permit(:content, :post_id)
   end

end
