require 'rails_helper'

feature 'admin deletes review', %{
  As an administrator of Date Bites
  I want to delete a review
  So that I can remove inappropriate reviews from the site.
} do

  # Acceptance Criteria:
  # [X] I must be logged in as an admin; if I am not, when I visit
  # /admin/reviews - I receive an error and then redirected to the home page
  # [X] I can delete a review by visiting admin/reviews and clicking on
  # a delete link next to the entry associated to the review
  # [X] I receive a confirmation when a review has been deleted
  # [X] After deleting a review, I am redirected to the admin/reviews
  # page

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:review) { FactoryGirl.create(:review) }

  scenario 'admin deletes reviews' do
    sign_in_as(admin)
    visit "/admin/reviews"

    click_button('Delete')

    expect(page).to have_content("Review has been deleted.")
    expect(page).to_not have_content(review.body)
  end

  scenario 'unauthorized users are redirected' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit "/admin/reviews"

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end
