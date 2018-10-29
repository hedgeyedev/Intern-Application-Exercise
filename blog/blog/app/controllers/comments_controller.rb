class CommentsController < ApplicationController
  def show
  end

  def new
  	binding.pry
  	@post = Post.find(params[:post_id])
  	@comment = Comment.new
  end

  def create
  	if current_user
	  	@post = Post.find(params[:post_id])
	  	@comment = @post.comments.new(comment_params)
	  	@comment.user_id = current_user.id
	  	@comment.save
	  	redirect_to post_path(@post)
	else
		flash[:error] = "You must be logged in to add a comment"
		redirect_to "/login"
	end	
  end

  def delete
  end


  private

  def comment_params
      params.require(:comment).permit(:content, :post_id)
   end

end
