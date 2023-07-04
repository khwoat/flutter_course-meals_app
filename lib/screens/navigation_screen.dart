import 'package:basic_todo_app/providers/favorites_provider.dart';
import 'package:basic_todo_app/providers/filters_provider.dart';
import 'package:basic_todo_app/screens/categories_screen.dart';
import 'package:basic_todo_app/screens/filters_screen.dart';
import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:basic_todo_app/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Navigation screen that has a bottom navigation bar for go to the selected page.
class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
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
    // Filter meals from user filter setting
    final filteredMeals = ref.watch(filteredMealsProvider);

    // Set all pages
    final favoriteMeals = ref.watch(favoritesProvider);
    Map<String, Widget> pages = {
      'Categories': CategoriesScreen(
        filteredMeals: filteredMeals,
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
