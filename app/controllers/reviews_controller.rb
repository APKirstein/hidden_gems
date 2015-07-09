class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:upvote, :downvote]

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

  def upvote
    @review = Review.find(params[:id])
    @vote = @review.votes.find(params[:id])
    @review.upvote_by current_user

    respond_to do |format|
      if @review.upvote_by current_user
        format.html { redirect_to restaurant_path(params[:restaurant_id]), notice: "We heard your Vote!" }
        # format.js
        format.json { render json: { size: @review.get_upvotes.size, id: @review.id } }
      end
    end
  end

  def downvote
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.downvote_from current_user
        format.html { redirect_to :back, notice: "We heard your Vote!" }
        # format.js
        format.json { render json: { size: @review.get_downvotes.size, id: @review.id } }
      end
    end
  end

  protected

  def review_params
    params.require(:review).permit(:restaurant_id, :value, :proximity,
      :volume, :originality, :body)
  end
end
