import 'package:basic_todo_app/widgets/meal_item.dart';
import 'package:flutter/material.dart';

import '../models/meal.dart';

/// Meals Screen that contains all meals of selected category.
///
/// Required [title] to show in app bar.
/// Required [meals] to show a list view of meal.
class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: _contents(context),
    );
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
        itemBuilder: (context, index) => MealItem(meal: meals[index]),
      );
    }
  }
}
