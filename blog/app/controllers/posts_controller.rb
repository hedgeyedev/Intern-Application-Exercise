class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :delete]

  def index
    @posts = Post.paginate(:page => params[:page], :per_page => 5)
    @newest_posts = Post.newest.paginate(:page => params[:page], :per_page => 5)
    @popular_posts = Post.most_popular.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    update = @post.views += 1
    @post.update_attributes(views: update)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

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

  def delete
    if @post.vote_to_delete 
      redirect_to posts_path
    else 
      redirect_to post_path(@post), notice: "Delete vote submitted!"
    end
  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :author, :author_image, :featured_image)
    end
end
