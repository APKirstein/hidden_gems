class ReviewNotifier < ActionMailer::Base
  default from: "admin@datebites.com"

  def new_review(review)
    @review = review

    mail(
      to: review.user.email,
      subject: "New Review for #{review.restaurant.name}")
  end
end
