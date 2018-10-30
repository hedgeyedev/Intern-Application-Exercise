class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # POST posts/:id/likes
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
