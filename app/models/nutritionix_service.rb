class NutritionixService
  include HTTParty

  BASE_URL = "https://trackapi.nutritionix.com/v2"

  HEADERS = {
    'Content-Type': 'application/json',
    'x-app-id': ENV['nutritionix_app_id'],
    'x-app-key': ENV['nutritionix_app_key'],
    'x-remote-user-id': '0'
  }

  def get_meal_by_name(name)
    response     = HTTParty.post("#{BASE_URL}/natural/nutrients", headers: HEADERS, body: {query: name}.to_json).to_s
    parsed       = JSON.parse(response, {symbolize_names: true})

    return {
      thumbnail: parsed[:foods][0][:photo][:thumb],
      food_name: parsed[:foods][0][:food_name].capitalize,
      quantity: parsed[:foods][0][:serving_qty],
      units: parsed[:foods][0][:serving_unit],
      calories: parsed[:foods][0][:nf_calories]
    }
  end
end