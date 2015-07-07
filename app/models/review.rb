class Review < ActiveRecord::Base
  VALUES = [["1 - BK Lounge maybe?", 1], ["2", 2], ["3", 3], ["4", 4],
    ["5 - worth it", 5]]

  PROXIMITY = [["1 - bring hiking boots", 1], ["2", 2], ["3", 3],
    ["4", 4], ["5 - right next door", 5]]

  VOLUME = [["1 - I needed to scream", 1], ["2", 2], ["3", 3],
    ["4", 4], ["5 - very pleasant", 5]]

  ORIGINALITY = [["1 - same ol' same", 1], ["2", 2], ["3", 3],
    ["4", 4], ["5 - tweeting about it now", 5]]

  belongs_to :user
  belongs_to :restaurant

  validates :value, presence: true, numericality: { greater_than: 0,
    less_than_or_equal_to: 5 }
  validates :proximity, presence: true, numericality: { greater_than: 0,
            less_than_or_equal_to: 5 }
  validates :volume, presence: true, numericality: { greater_than: 0,
        less_than_or_equal_to: 5 }
  validates :originality, presence: true, numericality: { greater_than: 0,
    less_than_or_equal_to: 5 }
end
