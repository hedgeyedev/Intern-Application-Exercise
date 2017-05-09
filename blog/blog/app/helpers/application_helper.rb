module ApplicationHelper

  # Shortens post title, if necessary
  def convert_title(post_title = '')
    x = 25
    if post_title.length >= x
      post_title[0..(x-2)] + " ..."
    else
      post_title
    end
  end

  # Capitalizes first word in content of post, if it exists
  def capitalize_first(post_content)
    if post_content.length != 0
      post_content[0].upcase
    else
      ""
    end
  end
end
