class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :update_like, :update_dislike]
  skip_before_action :verify_authenticity_token, :only => [:update_like, :update_dislike]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
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
    # set_post 
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
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @comment = Comment.new
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
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

  # POST /posts/1/update_like
  def update_like
    @post.likes +=1
    @post.save
  end

   # POST /posts/1/update_dislike
  def update_dislike
    @post.dislikes +=1
    @post.save
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
