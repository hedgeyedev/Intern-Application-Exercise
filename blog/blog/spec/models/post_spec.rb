RSpec.describe Post, type: :model do
  describe "Create a new post" do
    before { @post1 = create(:post) }
    context "successfully create a new post" do
      it "should be valid" do
        expect(@post1).to be_valid
      end
    end
    context "unsuccessfully create a new post" do
      it "should fail if there is not title" do
        @post1.title = ""
        expect(@post1).to_not be_valid
      end
    end
  end
  describe "Associations" do
    it "should belong to one user" do
      post = Post.reflect_on_association(:user)
      expect(post.macro).to eq(:belongs_to)
    end
    it "should have a has one user association" do
      post = Post.reflect_on_association(:rich_text_content)
      expect(post.macro).to eq(:has_one)
    end
  end
end
