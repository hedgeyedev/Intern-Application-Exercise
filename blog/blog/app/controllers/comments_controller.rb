class CommentsController < ApplicationController

  # POST /posts/:id/comments
  def create
  	if current_user
	  	@post = Post.find(params[:post_id])
	  	@comment = @post.comments.new(comment_params)
	  	@comment.user_id = current_user.id
      if @comment.save
      flash[:notice] = "You created a comment successfully"
	  	redirect_to post_path(@post)
	     else
		  flash[:error] = @comment.errors.full_messages.to_sentence
		  redirect_to post_path(@post)
	     end
    else
    	flash[:error] = "You must be logged in to comment a post"
      redirect_to login_path()
    end
  end

  # DELETE /posts/:id/comments/:id
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
