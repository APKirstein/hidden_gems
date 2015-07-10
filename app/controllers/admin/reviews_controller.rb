module Admin
  class ReviewsController < ApplicationController
    before_filter :authorize_admin!
    def index
      @reviews = Review.all.page(params[:page])
    end

    def destroy
      @review = Review.find(params[:id])
      @review.destroy
      flash[:notice] = "Review has been deleted."
      redirect_to admin_reviews_path
    end
  end
end
