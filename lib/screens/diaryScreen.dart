import 'package:flutter/material.dart';
import '../estructuras/meal_entry.dart';
import '../widgets/top_bar.dart';
import '../widgets/macro_box.dart';

class DiaryScreen extends StatelessWidget {
  final List<MealEntry> addedMeals;
  const DiaryScreen({super.key, required this.addedMeals});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<MealEntry>> mealsByType = {
      'Breakfast': [],
      'Lunch': [],
      'Dinner': [],
      'New': [],
    };
    int totalCalories = 0, totalProteins = 0, totalFats = 0, totalCarbs = 0;
    for (final entry in addedMeals) {
      mealsByType[entry.mealType]?.add(entry);
      double factor = entry.quantity / 100.0;
      totalCalories += (entry.food.calories * factor).round();
      totalProteins += (entry.food.proteins * factor).round();
      totalFats += (entry.food.fats * factor).round();
      totalCarbs += (entry.food.carbs * factor).round();
    }
    return Column(
      children: [
        const TopBar(title: 'Mercurio'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Nutrients Indicator',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MacroBox(
                    label: 'Proteins',
                    value: totalProteins,
                    color: const Color(0xFFFF7F7F),
                  ),
                  MacroBox(
                    label: 'Fats',
                    value: totalFats,
                    color: const Color(0xFFFFC68A),
                  ),
                  MacroBox(
                    label: 'Carbs',
                    value: totalCarbs,
                    color: const Color(0xFF6EC99E),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: totalCalories / 2000.0,
                      backgroundColor: Colors.grey[200],
                      color: const Color(0xFF72C2F1),
                      minHeight: 8,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text('$totalCalories Cal'),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            children: [
              for (final mealType in ['Breakfast', 'Lunch', 'Dinner', 'New'])
                if (mealsByType[mealType]!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mealType,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      ...mealsByType[mealType]!.map(
                        (entry) => Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: const Color(0xFFA2E3C4).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  entry.food.name[0],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF6EC99E),
                                  ),
                                ),
                                // Aquí puedes poner la imagen:
                                // child: Image.asset(entry.food.imagePath!),
                              ),
                            ),
                            title: Text(entry.food.name),
                            subtitle: Text('${entry.quantity.round()}g'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${((entry.food.calories * entry.quantity / 100)).round()} Cal',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${((entry.food.proteins * entry.quantity / 100)).round()}P/${((entry.food.fats * entry.quantity / 100)).round()}F/${((entry.food.carbs * entry.quantity / 100)).round()}C',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
            ],
          ),
        ),
      ],
    );
  }
}
