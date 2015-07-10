require 'rails_helper'

feature 'user can search for a restaurant', %{
  As a user
  I want to search for a restaurant using a search bar
  To see if it got good reviews
} do

  # [X] - I run a search for restaurants using a search box

  let!(:restaurant) { FactoryGirl.create(:restaurant) }

  scenario 'user visits the index page' do
    visit root_path

    fill_in "search", with: restaurant.name
    click_button "hidden-submit", visible: false

    uri = URI.parse(current_url)
    page.current_path == uri

    expect(page).to have_content(restaurant.name)
  end
end
