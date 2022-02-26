require_relative '../rails_helper.rb'
RSpec.describe User, type: :model do
  describe "Creates a new user" do
    before { @user1 = create(:user) }
    context "successfully create a new user" do
      it "should be a valid user" do
        expect(@user1).to be_valid
      end
    end
    context "password is too short" do
      before { @user1.password = "a" }
      it "should not be valid when password is too short" do
        expect(@user1).to_not be_valid
      end
    end
    context "password is blank" do
      before { @user1.password = "" }
      it "should not be valid when password is blank" do
        expect(@user1).to_not be_valid
      end
    end
    context "email is invalid" do
      before { @user1.email = "toad" }
      it "should not be valid when email isn't a valid email" do
        expect(@user1).to_not be_valid
      end
    end
  end
end
