import 'package:flutter/material.dart';
import 'estructuras/food.dart';
import 'estructuras/meal_entry.dart';
import 'screens/foodScreen.dart';
import 'screens/diaryScreen.dart';

void main() {
  runApp(const ProteIAApp());
}

class ProteIAApp extends StatelessWidget {
  const ProteIAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProteIA',
      theme: ThemeData(
        primaryColor: const Color(0xFFA2E3C4),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF72C2F1),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF303030)),
          bodyMedium: TextStyle(color: Color(0xFF303030)),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<MealEntry> _addedMeals = [];

  void _addMeal(MealEntry entry) {
    setState(() {
      _addedMeals.add(entry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = <Widget>[
      FoodScreen(addedMeals: _addedMeals, onAddMeal: _addMeal),
      DiaryScreen(addedMeals: _addedMeals),
    ];
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF9F9F9),
        selectedItemColor: const Color(0xFFA2E3C4),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('lib/Assets/proteIAlogo.png'), size: 28),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            label: 'Diary',
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final String title;
  final Widget? action;
  const TopBar({required this.title, this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'lib/Assets/Fotodeperfil.png',
                  ),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Mercurio',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            action ?? Container(),
          ],
        ),
      ),
    );
  }
}

// Modelo de alimento
class Food {
  final String name;
  final int calories;
  final int proteins;
  final int fats;
  final int carbs;
  final String? imagePath; // Ruta de la imagen (opcional)

  Food({
    required this.name,
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbs,
    this.imagePath,
  });
}

// Lista hardcodeada de alimentos principales
final List<Food> foodList = [
  Food(
    name: 'Chicken Breast',
    calories: 165,
    proteins: 31,
    fats: 3,
    carbs: 0,
    // imagePath: 'lib/Assets/chicken.png', // <-- Agrega la imagen aquí
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

// Modelo de comida agregada
class MealEntry {
  final Food food;
  final double quantity; // en gramos o porciones
  final String mealType; // Breakfast, Lunch, Dinner, New

  MealEntry({
    required this.food,
    required this.quantity,
    required this.mealType,
  });
}

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
                      _MacroBox(
                        label: 'Calories',
                        value: adjCalories,
                        color: Color(0xFF72C2F1),
                      ),
                      _MacroBox(
                        label: 'Proteins',
                        value: adjProteins,
                        color: Color(0xFFFF7F7F),
                      ),
                      _MacroBox(
                        label: 'Fats',
                        value: adjFats,
                        color: Color(0xFFFFC68A),
                      ),
                      _MacroBox(
                        label: 'Carbs',
                        value: adjCarbs,
                        color: Color(0xFF6EC99E),
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

class _MacroBox extends StatelessWidget {
  final String label;
  final int value;
  final Color color;
  const _MacroBox({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class DiaryScreen extends StatelessWidget {
  final List<MealEntry> addedMeals;
  const DiaryScreen({super.key, required this.addedMeals});

  @override
  Widget build(BuildContext context) {
    // Agrupar comidas
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
                  _MacroBox(
                    label: 'Proteins',
                    value: totalProteins,
                    color: Color(0xFFFF7F7F),
                  ),
                  _MacroBox(
                    label: 'Fats',
                    value: totalFats,
                    color: Color(0xFFFFC68A),
                  ),
                  _MacroBox(
                    label: 'Carbs',
                    value: totalCarbs,
                    color: Color(0xFF6EC99E),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: totalCalories / 2000.0, // Meta ejemplo: 2000 cal
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
