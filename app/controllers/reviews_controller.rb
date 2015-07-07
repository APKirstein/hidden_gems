class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.restaurant_id = params[:restaurant_id]

    if @review.save
      ReviewNotifier.new_review(@review).deliver_later
      flash[:notice] = "Thanks for your review!"
      redirect_to @review.restaurant
    else
      flash[:notice] = @review.errors.full_messages.join(". ")
      redirect_to @review.restaurant
    end
  end

  protected

  def review_params
    params.require(:review).permit(:restaurant_id, :value, :proximity,
      :volume, :originality, :body)
  end
end
