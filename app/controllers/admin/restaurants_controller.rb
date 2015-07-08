module Admin
  class RestaurantsController < ApplicationController
    before_filter :authorize_admin!
    def index
      @restaurants = Restaurant.all.page(params[:page])
    end

    def destroy
      @restaurant = Restaurant.find(params[:id])
      @restaurant.destroy
      flash[:notice] = "Successfully deleted #{@restaurant.name}!"
      redirect_to admin_restaurants_path
    end
  end
end
