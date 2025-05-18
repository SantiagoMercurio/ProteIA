import 'food.dart';

class MealEntry {
  final Food food;
  final double quantity;
  final String mealType;

  MealEntry({
    required this.food,
    required this.quantity,
    required this.mealType,
  });
}
