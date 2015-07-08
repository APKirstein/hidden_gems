require 'rails_helper'

feature 'admin deletes restaurant', %{
  As an administrator of Date Bites
  I want to delete a restaurant
  So that I can remove closed restaurants from the site.
} do

  # Acceptance Criteria:
  # [X] I must be logged in as an admin; if I am not, when I visit
  # /admin/restaurants - I receive an error and then redirected to the home page
  # [X] I can delete a restaurant by visiting admin/restaurants and clicking on
  # a delete link next to the entry associated to the restaurant
  # [X] I receive a confirmation when a restaurant has been deleted
  # [X] After deleting a restaurant, I am redirected to the admin/restaurants
  # page

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:restaurant) { FactoryGirl.create(:restaurant) }
  
  scenario 'admin deletes restaurants & sees paginated restaurants' do
    sign_in_as(admin)
    visit admin_restaurants_path

    click_button('Delete')

    expect(page).to have_content("Successfully deleted #{restaurant.name}!")
    expect(page).to_not have_content(restaurant.address)
  end

  scenario 'unauthorized users are redirected' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    visit admin_restaurants_path

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end
