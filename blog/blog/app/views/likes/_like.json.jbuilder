json.extract! like, :id, :commenter_id, :post_id, :like, :dislike, :created_at, :updated_at
json.url like_url(like, format: :json)
