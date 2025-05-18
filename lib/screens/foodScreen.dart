import 'package:flutter/material.dart';
import '../estructuras/food.dart';
import '../estructuras/meal_entry.dart';
import '../widgets/top_bar.dart';
import '../widgets/macro_box.dart';

class FoodScreen extends StatefulWidget {
  final List<MealEntry> addedMeals;
  final void Function(MealEntry) onAddMeal;
  const FoodScreen({
    super.key,
    required this.addedMeals,
    required this.onAddMeal,
  });

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  String _search = '';

  void _showAddFoodModal(Food food) async {
    String selectedMeal = 'Breakfast';
    double quantity = 100; // valor por defecto (100g)
    final result = await showModalBottomSheet<MealEntry>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            double factor = quantity / 100.0;
            int adjCalories = (food.calories * factor).round();
            int adjProteins = (food.proteins * factor).round();
            int adjFats = (food.fats * factor).round();
            int adjCarbs = (food.carbs * factor).round();
            return Padding(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        food.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text('Select meal'),
                  DropdownButton<String>(
                    value: selectedMeal,
                    isExpanded: true,
                    items:
                        ['Breakfast', 'Lunch', 'Dinner', 'New']
                            .map(
                              (e) => DropdownMenuItem(value: e, child: Text(e)),
                            )
                            .toList(),
                    onChanged: (val) {
                      setModalState(() => selectedMeal = val!);
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text('Quantity (g)'),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          min: 10,
                          max: 500,
                          divisions: 49,
                          value: quantity,
                          label: '${quantity.round()}g',
                          onChanged: (val) {
                            setModalState(() => quantity = val);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          '${quantity.round()}g',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MacroBox(
                        label: 'Calories',
                        value: adjCalories,
                        color: const Color(0xFF72C2F1),
                      ),
                      MacroBox(
                        label: 'Proteins',
                        value: adjProteins,
                        color: const Color(0xFFFF7F7F),
                      ),
                      MacroBox(
                        label: 'Fats',
                        value: adjFats,
                        color: const Color(0xFFFFC68A),
                      ),
                      MacroBox(
                        label: 'Carbs',
                        value: adjCarbs,
                        color: const Color(0xFF6EC99E),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFA2E3C4),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () {
                        Navigator.pop(
                          context,
                          MealEntry(
                            food: food,
                            quantity: quantity,
                            mealType: selectedMeal,
                          ),
                        );
                      },
                      child: const Text('Add to meal'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
    if (result != null) {
      widget.onAddMeal(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredList =
        foodList
            .where(
              (food) => food.name.toLowerCase().contains(_search.toLowerCase()),
            )
            .toList();
    return Column(
      children: [
        const TopBar(title: 'Mercurio'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for ingredients',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                _search = value;
              });
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final food = filteredList[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: const Color(0xFFA2E3C4).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        food.name[0],
                        style: const TextStyle(
                          fontSize: 28,
                          color: Color(0xFF6EC99E),
                        ),
                      ),
                      // Aquí puedes poner la imagen:
                      // child: Image.asset(food.imagePath!),
                    ),
                  ),
                  title: Text(
                    food.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${food.calories} Cal'),
                  onTap: () {
                    _showAddFoodModal(food);
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
