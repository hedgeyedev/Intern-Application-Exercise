class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment])

    respond_to do |format|
      if @comment.save
        format.js {}
        format.json {render json :@comment }
      else
        #format.html
        format.js {}
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @post = Post.find(params[:post_id])
    
    respond_to do |format|
       format.js{}
       format.json { render json: @post.comments }
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js{}
      format.json { head :no_content }
    end
  end

  def new
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.js{}
      format.json { head :no_content }
    end
  end

  #comments/latest/:time_b/:time_e
  def latest


    @comments = Comment.order("created_at DESC")
                          .limit(LATEST_COMMENTS_LIMIT)
                          #.where("created_at between ? and ? ",params[:time_b],params[:time_e]);

    respond_to do |format|
      format.js{}
      format.json { head :no_content }
    end
  end

  

end
