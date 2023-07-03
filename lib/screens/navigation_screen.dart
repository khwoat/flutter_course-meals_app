import 'package:basic_todo_app/providers/favorites_provider.dart';
import 'package:basic_todo_app/providers/filters_provider.dart';
import 'package:basic_todo_app/providers/meals_provider.dart';
import 'package:basic_todo_app/screens/categories_screen.dart';
import 'package:basic_todo_app/screens/filters_screen.dart';
import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:basic_todo_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

/// Navigation screen that has a bottom navigation bar for go to the selected page.
class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  List<Meal> _filteredMeals = [];

  int activePageIndex = 0;

  /// Go to the page that is selected
  void _selectPage(int index) {
    setState(() {
      activePageIndex = index;
    });
  }

  void _onSelectDrawerMenu(DrawerMenuIdentifier identifier) {
    Navigator.of(context).pop();
    if (identifier == DrawerMenuIdentifier.filters) {
      Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final filters = ref.watch(filtersProvider);

    // Filter meals from user filter setting
    _filteredMeals = meals.where((meal) {
      if (filters[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filters[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filters[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filters[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    // Set all pages
    final favoriteMeals = ref.watch(favoritesProvider);
    Map<String, Widget> pages = {
      'Categories': CategoriesScreen(
        filteredMeals: _filteredMeals,
      ),
      'Your Favorites': MealsScreen(
        meals: favoriteMeals,
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
