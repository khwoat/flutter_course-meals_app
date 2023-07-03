import 'package:basic_todo_app/screens/meals_screen.dart';
import 'package:basic_todo_app/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/category.dart';
import '../models/meal.dart';

/// Categories Screen that contains all categories to select for filtering meals.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredMeals,
  });

  final List<Meal> filteredMeals;

  /// It will bring to Meals Screen that will show all meals of selected category.
  void _selectCategory(BuildContext context, Category category) {
    final categoryMeals = filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: categoryMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // GridView for showing Categories
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: availableCategories.length,
      itemBuilder: (context, index) => CategoryGridItem(
        category: availableCategories[index],
        onSelectCategory: () {
          _selectCategory(context, availableCategories[index]);
        },
      ),
    );
  }
}
