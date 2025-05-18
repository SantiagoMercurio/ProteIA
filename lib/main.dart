import 'package:flutter/material.dart';

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

  static const List<Widget> _screens = <Widget>[FoodScreen(), DiaryScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF9F9F9),
        selectedItemColor: const Color(0xFFA2E3C4),
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
                  backgroundImage: AssetImage('lib/Assets/proteIAlogo.png'),
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

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TopBar(title: 'Mercurio'),
        Expanded(
          child: Center(
            child: Text('Food Screen'),
          ), // Aquí irá la lista de alimentos
        ),
      ],
    );
  }
}

class DiaryScreen extends StatelessWidget {
  const DiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TopBar(title: 'Mercurio'),
        Expanded(
          child: Center(
            child: Text('Diary Screen'),
          ), // Aquí irá el resumen diario
        ),
      ],
    );
  }
}
