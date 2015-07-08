require 'rails_helper'

feature 'admin can paginate through list of restaurants', %{
  As an administrator of Date Bites
  I want to see a list of restaurants that are paginated
  So that I can more quickly navigate the site.
} do

  # Acceptance Criteria:
  # [] I must be logged in as an admin; if I am not, when I visit
  # /admin/restaurants - I receive an error and then redirected to the home page
  # [] I see a list of restaurants broken up into different pages
  # [] I can click on a "Next" to see the next set/page

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:restaurant) { FactoryGirl.create(:restaurant) }

  before(:each) do
    50.times { FactoryGirl.create(:restaurant) }
  end

  scenario 'admin sees paginated restaurants' do
    sign_in_as(admin)
    visit admin_restaurants_path

    click_link 'Next'

    uri = URI.parse(current_url)
    expect("#{uri.path}?#{uri.query}").to eq(admin_restaurants_path(page: '2'))
    expect(page).to_not have_content(restaurant.name)
  end
end
