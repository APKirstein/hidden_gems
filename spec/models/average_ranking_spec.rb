require 'rails_helper'

describe Restaurant do
  let(:restaurant) { Restaurant.create(
    name: "Test",
    address: "33 Harrison Ave",
    city: "Boston",
    state: "MA",
    zip_code: "02111"
  ) }

  describe "#average_ranking" do
    it "returns an average of the column if available for that restaurant" do
      Review.create(
        user_id: 1,
        restaurant_id: restaurant.id,
        value: 2,
        proximity: 4,
        volume: 5,
        originality: 1
      )
      Review.create(
        user_id: 1,
        restaurant_id: restaurant.id,
        value: 4,
        proximity: 5,
        volume: 5,
        originality: 3
      )
      expect(restaurant.average_ranking('value')).to eq(3)
      expect(restaurant.average_ranking('proximity')).to eq(5)
      expect(restaurant.average_ranking('volume')).to eq(5)
      expect(restaurant.average_ranking('originality')).to eq(2)
    end
    it "returns 'n/a' if column is empty for that restaurant" do
      expect(restaurant.average_ranking('value')).to eq('n/a')
      expect(restaurant.average_ranking('proximity')).to eq('n/a')
      expect(restaurant.average_ranking('volume')).to eq('n/a')
      expect(restaurant.average_ranking('originality')).to eq('n/a')
    end
  end
end
