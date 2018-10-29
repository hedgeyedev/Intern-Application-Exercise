class CommentsController < ApplicationController
  def show
  end

  def new
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

  def destroy
  	@post = Post.find(params[:post_id])
  	@comment = @post.comments.find(params[:id])
  	@comment.destroy
  	flash[:notice] = "Your comment has been successfully deleted!"
  	redirect_to post_path(@post)
  end


  private

  def comment_params
      params.require(:comment).permit(:content, :post_id)
   end

end
