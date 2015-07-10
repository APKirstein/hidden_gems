class ReviewNotifier < ActionMailer::Base
  default from: "admin@datebites.com"

  def email(user_to_email, review)
    mail(
      to: user_to_email.email,
      subject: "New Review for #{review.restaurant.name}")
  end

  def new_review(review)
    @review = review

    users_to_email = User.where(role: "admin")
    users_to_email.each do |user_to_email|
      email(user_to_email, review)
    end
  end
end
