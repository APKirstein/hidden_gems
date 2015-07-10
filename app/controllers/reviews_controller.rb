class ReviewsController < ApplicationController
  before_action :authenticate_user!

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

  def upvote
    @review = Review.find(params[:id])
    @review.upvote_by current_user

    respond_to do |format|
      if @review.upvote_by current_user
        format.json {
          render json: {
            id: @review.id,
            upsize: @review.get_upvotes.size,
            downsize: @review.get_downvotes.size
          }
        }
      else
        render json: {}
      end
    end
  end

  def downvote
    @review = Review.find(params[:id])
    @review.downvote_by current_user

    respond_to do |format|
      if @review.downvote_from current_user
        format.json {
          render json: {
            id: @review.id,
            downsize: @review.get_downvotes.size,
            upsize: @review.get_upvotes.size
          }
        }
      else
        render json: {}
      end
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

  def destroy
    @review = Review.find(params[:id]).destroy
    flash[:notice] = "Your review has been deleted"
    redirect_to restaurant_path(params[:restaurant_id])
  end

  protected

  def review_params
    params.require(:review).permit(:value, :proximity,
      :volume, :originality, :body)
  end
end
