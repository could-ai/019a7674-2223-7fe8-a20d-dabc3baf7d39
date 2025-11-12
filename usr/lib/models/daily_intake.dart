import 'food_item.dart';

class DailyIntake {
  final List<FoodItem> foods = [];

  void addFood(FoodItem food) {
    foods.add(food);
  }

  void removeFood(int index) {
    if (index >= 0 && index < foods.length) {
      foods.removeAt(index);
    }
  }

  double get totalCalories {
    return foods.fold(0, (sum, food) => sum + food.calories);
  }

  double get totalProtein {
    return foods.fold(0, (sum, food) => sum + food.protein);
  }

  double get totalCarbs {
    return foods.fold(0, (sum, food) => sum + food.carbs);
  }

  double get totalFat {
    return foods.fold(0, (sum, food) => sum + food.fat);
  }

  void clear() {
    foods.clear();
  }
}