require_relative '../rails_helper.rb'

RSpec.describe Comment, type: :model do
  describe "Create a new comment" do
    before do
      @comment = FactoryBot.create :comment
    end

    context "when comment is filled" do
      it "should be a valid comment" do
        expect(@comment).to be_valid
      end
    end
    context "when comment is not filled" do
      it "should not be a valid comment" do
        @comment.comment = ""
        expect(@comment).to_not be_valid
      end
    end
  end
  describe "Associations" do
    it "should belong to a user" do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eq(:belongs_to)
    end
    it "should belong to a post" do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end
end
