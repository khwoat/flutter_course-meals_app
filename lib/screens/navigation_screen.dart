import 'package:basic_todo_app/data/dummy_data.dart';
import 'package:basic_todo_app/screens/categories_screen.dart';
import 'package:basic_todo_app/screens/filters_screen.dart';
import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:basic_todo_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

const kInitialFilters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

/// Navigation screen that has a bottom navigation bar for go to the selected page.
class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  List<Meal> _filteredMeals = [];
  final List<Meal> _favoriteMeals = [];

  Map<Filters, bool> _selectedFilters = kInitialFilters;

  int activePageIndex = 0;

  /// Go to the page that is selected
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  void _onSelectDrawerMenu(DrawerMenuIdentifier identifier) async {
    Navigator.of(context).pop();
    if (identifier == DrawerMenuIdentifier.filters) {
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            selectedFilters: _selectedFilters,
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
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
    // Filter meals from user filter setting
    _filteredMeals = dummyMeals.where((meal) {
      if (_selectedFilters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    // Set all pages
    Map<String, Widget> pages = {
      'Categories': CategoriesScreen(
        onToggleFavorite: _toggleMealFavorite,
        filteredMeals: _filteredMeals,
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
      drawer: MainDrawer(onSelectMenu: _onSelectDrawerMenu),
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
