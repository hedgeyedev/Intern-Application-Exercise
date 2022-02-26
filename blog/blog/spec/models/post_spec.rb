require_relative '../rails_helper.rb'

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
      it "should fail if there is no context" do
        @post1.context = ""
        expect(@post1).to_not be_valid
      end
    end
  end
end
