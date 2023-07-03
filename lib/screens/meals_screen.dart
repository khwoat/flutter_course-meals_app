import 'package:basic_todo_app/screens/meal_details_screen.dart';
import 'package:basic_todo_app/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

/// Meals Screen that contains all meals of selected category.
///
/// [title] to show a title in app bar.
/// Required [meals] to show a list view of meal.
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  /// Call when select at the meal item.
  /// It will push to detail page.
  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailsScreen(
          meal: meal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return _contents(context);
    } else {
      return Scaffold(
        appBar: AppBar(title: Text(title!)),
        body: _contents(context),
      );
    }
  }

  /// Content of all meals of selected category.
  Widget _contents(BuildContext context) {
    // If meals argument is empty show found nothing text.
    // Otherwise, show ListView of MealItem.
    if (meals.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh oh, ....... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Try select another category.',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) => MealItem(
          meal: meals[index],
          onSelectMeal: (meal) => _selectMeal(context, meal),
        ),
      );
    }
  }
}
