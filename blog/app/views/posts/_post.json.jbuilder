json.extract! post, :id, :title, :content, :created_at, :updated_at, :category, :author
json.url post_url(post, format: :json)
