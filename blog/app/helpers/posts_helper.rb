module PostsHelper
  def format_post(content)
    content.split(" ")[0 .. 75].join(" ")
  end
end
