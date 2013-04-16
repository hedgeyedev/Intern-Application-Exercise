module PostsHelper
  def most_popular
    @mp_posts = Post.order("readers DESC").limit(10).where("readers > ?",0);
  end
end
