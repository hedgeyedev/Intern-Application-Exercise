class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :update_like, :update_dislike]
  skip_before_action :verify_authenticity_token, :only => [:update_like, :update_dislike]
  
  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show  
    @likes_count = @post.likes.where(like: 1).count
    @dislikes_count =@post.likes.where(dislike: 1).count
  end

  # GET /posts/new
  def new
    if !current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to "/login"
    else 
      @post = Post.new
    end
  end

  # GET /posts/1/edit
  def edit
    if !current_user
      flash[:error] = "You must be logged in to see this page"
      redirect_to "/login"
    elsif current_user.id != @post.user_id 
      flash[:error] = "Only the author can edit this post"
      redirect_to "/posts"
    else
      render "edit"
    end

  end

  # POST /posts
  def create
    @post = Post.new(post_params)
    @comment = Comment.new
    @post.user_id = current_user.id
      if @post.save
        flash[:notice] = "Your post was successfully created!"
        redirect_to post_path(@post)
      else
        flash[:error] = @post.errors.full_messages.to_sentence
        redirect_to new_post_path()
      end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      flash[:notice] = "Your post was successfully updated!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to new_post_path()
    end
  end

  # DELETE /posts/1
  def destroy
    if !current_user
      flash[:error] = "You must be logged in to delete a post"
      redirect_to "/login"
    elsif current_user.id != @post.user_id 
      flash[:error] = "Only the author can delete a post"
      redirect_to "/posts"
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
