require 'rails_helper'

feature 'user updates details of a restaurant', %{
  As a user
  I want to update the details of a restaurant
  so I can have the latest information
} do

  # [ ] - I can see a form to update the restaurant details
  # [ ] - I can update the details of the restaurant
  # [ ] - I am redirected back to the restaurant show page with updated info

  let(:restaurant) { FactoryGirl.build(:restaurant) }

  scenario 'user updates show page' do
    visit restaurant_path(restaurant.id)
    click_link("Edit")
    fill_in('Address', :with => "155 New Drive")
    click_button("Update")

    expect(page).to have_content("155 New Drive")
  end
end
