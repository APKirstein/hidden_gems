require 'rails_helper'

RSpec.describe Review, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:restaurant) }
  
  it { should have_valid(:value).when(3) }
  it { should have_valid(:proximity).when(4) }
  it { should have_valid(:volume).when(3) }
  it { should have_valid(:originality).when(1) }
  it { should_not have_valid(:value).when(9) }
  it { should_not have_valid(:proximity).when(nil) }
  it { should_not have_valid(:volume).when(7) }
  it { should_not have_valid(:originality).when(10) }

  describe "#creator?" do
    it "returns the creator of the review" do
      user = FactoryGirl.create(:user)
      review = FactoryGirl.create(:review, user: user)
      expect(review.creator?(user)).to eql(true)
      # create a user
      # create a review with that user attached
      # expect that when we call review.creator? we get the user object
    end
  end
end
