require_relative '../rails_helper.rb'

RSpec.describe Comment, type: :model do
  describe "Create a new comment" do
    before { @comment1 = create(:comment) }
    context "when comment is filled" do
      it "should be a valid comment" do
        expect(@comment1).to be_valid
      end
    end
    context "when comment is not filled" do
      it "should not be a valid comment" do
        @comment1.comment = ""
        expect(@comment1).to_not be_valid
      end
    end
  end
end
