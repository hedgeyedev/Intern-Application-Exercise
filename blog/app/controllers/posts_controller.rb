class PostsController < ApplicationController
  # GET /posts/load/
  # only remote
  def load
    @posts = Post.order("updated_at DESC").limit(POSTS_LIMIT)

    @posts.each do |post|
        post.content = post.content.truncate(POST_BODY_SHORT_MAX_CHARS , :omission => "...");
    end

    respond_to do |format|
      format.js{}
      format.html{ render "index"} #fallback
    end
  end

  # GET /posts/all/
  # only remote gett all posts
  def all
    @posts = Post.order("updated_at DESC")
    @posts.each do |post|
        post.content = ""
    end
    respond_to do |format|

      format.js{}
      format.html{ render "index"} #fallback
    end
  end




  # GET /posts/popular
  def popular
    @posts = Post.order("readers DESC").limit(10).where("readers > ?",0);
    respond_to do |format|
      
      format.js {}
    end

  end

  # GET /posts/search/val
  # GET /posts/search/val.json
  def search
    escaped_query = params[:text].strip.gsub('%', '\%').gsub('_', '\_').gsub(/\s+/, '%')
    @posts = Post.order("updated_at DESC").find(:all, :conditions=> ["upper(title) like :eq or upper(content) like :eq", {:eq => "%" + escaped_query.upcase + "%"}])[0..POSTS_LIMIT-1]
    #@posts = Post.where("title like ?", "%#{params[:text]}%").order("created_at DESC");

    @posts.each do |post|
      post.content = post.content.truncate(POST_BODY_SHORT_MAX_CHARS , :omission => "...");
    end

    respond_to do |format|
      format.js{}
      format.json { render json: @posts }
      format.html{ render "index"} #fallback
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.order("updated_at DESC").limit(POSTS_LIMIT)
    @posts.each do |post|
      post.content = post.content.truncate(POST_BODY_SHORT_MAX_CHARS , :omission => "...");
    end

    respond_to do |format|
      
      format.html # index.html.erb
      format.js{}
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    
    @post = Post.find(params[:id])
    Post.increment_counter :readers, params[:id]
    
    respond_to do |format|
      format.js{}
      format.json { render json: @post }
      format.html{ render "index"} #fallback
    end
  end

  def after_edit

    @post = Post.find(params[:id])
    #@dirty = true;
    respond_to do |format|
      format.js{}
      format.json { render json: @post }
      
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.js {}
      format.json { render json: @post }
      format.html{ render "index"} #fallback
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    respond_to do |format|

        format.js {}
        format.html{ render "index"} #fallback
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Your post has been created!'
        
        #format.html { redirect_to :action => "show", :id => @post.id, :ignore_reader => '1'}

        format.html { redirect_to :action => "after_edit", :id => @post.id, :ignore_reader => '1', notice: 'Post was successfully created.' }
        format.json { head :no_content }
      else
        
        format.js {}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        
        flash[:notice] = 'Your post has been updated!'
        format.html { redirect_to :action => "after_edit", :id => @post.id, :ignore_reader => '1'}
        format.json { head :no_content }
      else
        #format.html { render html: "form" }
        format.js {}
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    @dirty = true;
    flash[:notice] = 'Your post has been deleted!'
    respond_to do |format|
      format.html { redirect_to :action => "load"}
      format.js{}
      format.json { head :no_content }
    end
  end
end
