class Post < ApplicationRecord
  MAX_OPENING_CHARS = 400.freeze

  # Returns the initial part of a blog post's content
  def opening
    content.size > MAX_OPENING_CHARS ? content[...MAX_OPENING_CHARS] + '...' : content
  end
end
