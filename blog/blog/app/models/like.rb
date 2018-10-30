class Like < ApplicationRecord
	belongs_to :post
	validates :commenter_id, uniqueness: { scope: :post_id,
    message: "We already saved your vote" }
end
