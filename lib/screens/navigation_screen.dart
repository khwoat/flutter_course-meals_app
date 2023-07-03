import 'package:basic_todo_app/screens/categories_screen.dart';
import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

/// Navigation screen that has a bottom navigation bar for go to the selected page.
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Meal> _favoriteMeals = [];

  int activePageIndex = 0;

  /// Go to the page that is selected
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  void _toggleMealFavorite(Meal meal) {
    final isExisted = _favoriteMeals.contains(meal);

    if (isExisted) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite!');
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // All pages
    Map<String, Widget> pages = {
      'Categories': CategoriesScreen(
        onToggleFavorite: _toggleMealFavorite,
      ),
      'Your Favorites': MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavorite,
      ),
    };

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
