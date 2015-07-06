class Review < ActiveRecord::Base
  VALUES = [["BK Lounge maybe?", 1], ["check please!", 2], ["not too shabby", 3], ["ok, now this I can do", 4], ["worth it", 5]]

  PROXIMITY = [["bring hiking boots", 1], ["quite a hike", 2], ["5-10 minute walk", 3], ["a block away", 4], ["right next door", 5]]

  VOLUME = [["I needed to scream", 1], ["I can just hear myself think", 2], ["decently loud", 3], ["just about right", 4], ["very pleasant", 5]]

  belongs_to :user
  belongs_to :restaurant

  validates :value, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :proximity, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :volume, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :originality, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
end
