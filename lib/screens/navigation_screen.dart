import 'package:basic_todo_app/screens/categories_screen.dart';
import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:flutter/material.dart';

/// Navigation screen that has a bottom navigation bar for go to the selected page.
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // All pages
  Map<String, Widget> pages = {
    'Categories': const CategoriesScreen(),
    'Your Favorites': const MealsScreen(meals: []),
  };

  int activePageIndex = 0;

  /// Go to the page that is selected
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pages.keys.elementAt(activePageIndex)),
      ),
      body: pages.values.elementAt(activePageIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: activePageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
