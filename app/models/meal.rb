class Meal < ApplicationRecord
  validates :name, :calories, presence: true
end
