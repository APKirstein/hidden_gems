class Restaurant < ActiveRecord::Base
  STATE = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true, inclusion: { in: STATE }
  validates :zip_code, format: { with: /\d{5}/ }, allow_blank: true

  def average_ranking(column)
    if !Review.where(restaurant_id: id).empty?
      average_score = Review.where(restaurant_id: id).average(column.to_sym)
      average_score.round
    else
      "n/a"
    end
  end
end




# Grouped values: This returns an ordered hash of the values and groups them. It
#   takes either a column name, or the name of a belongs_to association.
#
#     values = Person.group('last_name').maximum(:age)
#     puts values["Drake"]
#     # => 43
#
#     drake  = Family.find_by(last_name: 'Drake')
#     values = Person.group(:family).maximum(:age) # Person belongs_to :family
#     puts values[drake]
#     # => 43
#
#     values.each do |family, max_age|
#     ...
#     end
#
# Person.calculate(:count, :all) # The same as Person.count
# Person.average(:age) # SELECT AVG(age) FROM people...
#
# # Selects the minimum age for any family without any minors
# Person.group(:last_name).having("min(age) > 17").minimum(:age)
#
# Person.sum("2 * age")
