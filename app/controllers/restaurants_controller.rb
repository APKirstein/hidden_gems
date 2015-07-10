class RestaurantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params[:search] 
      @restaurants = Restaurant.search(params[:search]).page(params[:page])
    else
      @restaurants = Restaurant.all.page(params[:page])
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @reviews = @restaurant.reviews.page(params[:page]).per(5)
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Successfully created"
      redirect_to root_path
    else
      flash[:notice] = @restaurant.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(restaurant_params)
      flash[:success] = 'Changes saved successfully'
      redirect_to restaurant_path(@restaurant)
    else
      flash[:notice] = @restaurant.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id]).destroy
    flash[:notice] = "Deleted"
    redirect_to restaurants_path
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :state, :zip)
  end
end
