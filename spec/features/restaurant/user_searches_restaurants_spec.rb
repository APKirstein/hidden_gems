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
    click_button "Search", visible: false

    uri = URI.parse(current_url)
    utf8_path = uri.query.split("&").first
    search_path = uri.query.split("=").last

    expect("#{uri.path}?#{uri.query}").to eq("/restaurants?#{utf8_path}&search="
      + search_path)
    expect(page).to have_content(restaurant.name)
  end
end
