class Restaurant < ActiveRecord::Base
  STATE = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, inclusion: { in: STATE }
  validates :zip_code, format: { with: /\d{5}/ }, allow_blank: true

  def self.search(query)
    where("name ilike ?", "%#{query}%")
  end

  def average_ranking(column)
    if !Review.where(restaurant_id: id).empty?
      average_score = Review.where(restaurant_id: id).average(column.to_sym)
      average_score.round
    else
      "n/a"
    end
  end
end
