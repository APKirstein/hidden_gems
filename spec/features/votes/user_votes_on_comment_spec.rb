require 'rails_helper'

feature 'user votes on comment', %{
  As an authenticated user
  I want to vote
  So that I can show my support for a comment
} do
  # Acceptance Criteria
  # [x] If I'm signed in, I have an option to vote
  # [x] When I opt to upvote, I get a confirmation that it passes
  # [x] When I opt to downvote, I get a confirmation that it passes
  # [x] I can only upvote or downvote once
  # [ ] After I upvote, I can click on the upvote button again to unvote
  # [ ] After I downvote, I can click on the downvote button again to unvote
  # [x] If I am not signed in, and try to vote, I am redirected to log in

  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:review) {
    FactoryGirl.create(
    :review,
    user: user,
    restaurant: restaurant)
  }

  scenario 'authenticated user upvotes' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_on('▲')
    expect(page).to have_content('Successfully Upvoted')
  end

  scenario 'authenticated user downvotes' do
    sign_in_as(user)
    visit restaurant_path(restaurant)
    click_on('▼')
    expect(page).to have_content('Successfully Downvoted')
  end

  scenario 'unauthenticated user tries to downvote' do
    visit restaurant_path(restaurant)
    click_on('▼')
    expect(page).to have_content('You need to sign in or sign up')
  end
end
