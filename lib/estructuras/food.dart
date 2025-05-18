class Food {
  final String name;
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;
  final String? imagePath;

  Food({
    required this.name,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    this.imagePath,
  });
}

final List<Food> foodList = [
  Food(
    name: 'Chicken Breast',
    calories: 165,
    proteins: 31,
    fats: 3,
    carbs: 0,
    // imagePath: 'lib/Assets/chicken.png',
  ),
  Food(
    name: 'Egg',
    calories: 155,
    proteins: 13,
    fats: 11,
    carbs: 1,
    // imagePath: 'lib/Assets/egg.png',
  ),
  Food(
    name: 'Tomato',
    calories: 18,
    proteins: 1,
    fats: 0,
    carbs: 4,
    // imagePath: 'lib/Assets/tomato.png',
  ),
  Food(
    name: 'Rice',
    calories: 130,
    proteins: 2,
    fats: 0,
    carbs: 28,
    // imagePath: 'lib/Assets/rice.png',
  ),
  Food(
    name: 'Apple',
    calories: 52,
    proteins: 0,
    fats: 0,
    carbs: 14,
    // imagePath: 'lib/Assets/apple.png',
  ),
];
