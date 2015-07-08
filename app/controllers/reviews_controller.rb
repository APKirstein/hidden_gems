class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.restaurant = @restaurant

    if @review.save
      ReviewNotifier.new_review(@review).deliver_later
      flash[:notice] = "Thanks for your review!"
      redirect_to @restaurant
    else
      flash[:notice] = @review.errors.full_messages.join(". ")
      render "restaurants/show"
    end
  end

  def edit
    @review = Review.find(params[:id])
    unless @review.creator?(current_user)
      flash[:notice] = "You must be the logged-in creator of the review to edit"
      redirect_to restaurant_path(@review.restaurant_id)
    end
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      flash[:success] = 'Your changes have been saved!'
      redirect_to restaurant_path(@review.restaurant)
    else
      flash[:notice] = @review.errors.full_messages.join(". ")
      render :edit
    end
  end

  protected

  def review_params
    params.require(:review).permit(:value, :proximity,
      :volume, :originality, :body)
  end
end
