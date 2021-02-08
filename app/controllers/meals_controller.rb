class MealsController < ApplicationController
  before_action :set_meal, only: %i[ show edit update destroy ]

  def index
    @meals = Meal.all
  end

  def show
  end

  def new
    @meal = Meal.new
  end

  def edit
  end

  def create
    @meal = Meal.new(meal_params)

    if @meal.save
      redirect_to @meal, notice: "Meal was successfully created."
    else
      redirect_to @meal, alert: "Error creating meal..."
    end
  end

  def update
    if @meal.update(meal_params)
      redirect_to @meal, notice: "Meal successfully updated."
    else
      flash.now[:alert] = "Error updating meal..."
      render "edit"
    end
  end

  def destroy
    @meal.destroy

    redirect_to meals_path, notice: "Meal successfully destroyed."
  end

  private
    def set_meal
      @meal = Meal.find(params[:id])
    end

    def meal_params
      params.require(:meal).permit(:name, :calories)
    end
end
