class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new

    # @post = Post.find(params[:post_id].to_i)
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @post = Post.find(params[:post_id].to_i)
    if current_user
    @like = Like.new()
    @like.post_id = @post.id
    @like.like = params[:like].to_i
    @like.dislike = params[:dislike].to_i
    @like.commenter_id = current_user.id
      if @like.save
        flash[:notice] = "You voted for this post"
        redirect_to post_path(@post)
      else
        flash[:notice] = "We have already saved your vote"
        redirect_to post_path(@post)
      end

    else
      flash[:error] = "You must be logged in to see this page"
      redirect_to "/login"
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: 'Like was successfully updated.' }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
    @like.destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: 'Like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:post_id, :like, :dislike)
    end
end
