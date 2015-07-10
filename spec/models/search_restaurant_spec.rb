require 'rails_helper'

describe Restaurant do
  describe '.search' do
    it 'should return restaurants with the name queried' do
      restaurant = Restaurant.create(
        name: "Chipotle",
        address: "33 Harrison Ave",
        city: "Boston",
        state: "MA",
        zip_code: "02111"
        )
      expect(Restaurant.search(restaurant.name)).to eq([restaurant])
    end

    it 'should return empty if there is no match' do
      expect(Restaurant.search('poop')).to be_empty
    end
  end
end
