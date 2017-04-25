class Post < ActiveRecord::Base

	has_many :comments, dependent: :destroy

	#create featured image for post
	has_attached_file :featured_image, styles: { show: "700x250#" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :featured_image, content_type: /\Aimage\/.*\Z/

  	#create author image for post
  	has_attached_file :author_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :author_image, content_type: /\Aimage\/.*\Z/

  	#get newest posts
	scope :newest, -> {order(created_at: :desc)}
	#get posts with the most views
	scope :most_popular, -> {order(views: :desc)}

	validates :title, presence: true, length: {maximum: 250}
	validates :content, presence: true

	#return the first paragaph for preview
	def preview 
		content.split("\n").first
	end

	#return the number of votes until the post is deleted
	def votes_until_delete
		5 - delete_votes
	end

	# increases vote to delete.  If the vote passes the threshold, then the post is deleted and the function returns 
	# true.  If not, then it returns false
	def vote_to_delete
		new_votes = delete_votes.to_i + 1
		update_attributes(delete_votes: new_votes)
		if votes_until_delete <= 0
			destroy!
			return true 
		else 
			return false
		end
	end
			



end
