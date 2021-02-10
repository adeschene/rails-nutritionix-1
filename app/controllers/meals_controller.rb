class MealsController < ApplicationController
  def index
    @meals = Meal.all
  end

  def create
    @meal = Meal.new(meal_params)

    hash = NutritionixService.new.get_meal_by_name(@meal.name)

    @meal.name = hash[:food_name]
    @meal.thumbnail = hash[:thumbnail]
    @meal.quantity = hash[:quantity]
    @meal.units = hash[:units]
    @meal.calories = hash[:calories]

    if @meal.save
      redirect_to meals_path, notice: "Meal successfully created."
    else
      redirect_to meals_path, alert: "Error creating meal..."
    end
  end

  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    redirect_to meals_path, notice: "Meal successfully destroyed."
  end

  private
    def meal_params
      params.require(:meal).permit(:name, :calories)
    end
end
