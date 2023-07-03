import 'package:flutter/material.dart';

enum Filters {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

/// Filters Screen that avaiable to config meals filters of the user.
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.selectedFilters,
  });

  final Map<Filters, bool> selectedFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilterSet = false;
  bool _lactoseFreeFilterSet = false;
  bool _vegetarianFilterSet = false;
  bool _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.selectedFilters[Filters.glutenFree]!;
    _lactoseFreeFilterSet = widget.selectedFilters[Filters.lactoseFree]!;
    _vegetarianFilterSet = widget.selectedFilters[Filters.vegetarian]!;
    _veganFilterSet = widget.selectedFilters[Filters.vegan]!;
  }

  /// Handle when pop this page.
  Future<bool> onPop() async {
    Navigator.of(context).pop({
      Filters.glutenFree: _glutenFreeFilterSet,
      Filters.lactoseFree: _lactoseFreeFilterSet,
      Filters.vegetarian: _vegetarianFilterSet,
      Filters.vegan: _veganFilterSet,
    });

    // Return false because it is pop already (above).
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        body: Column(
          children: [
            // Gluten filter tile
            SwitchListTile(
              value: _glutenFreeFilterSet,
              onChanged: (isChecked) => setState(() {
                _glutenFreeFilterSet = isChecked;
              }),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),

            // Lactose filter tile
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) => setState(() {
                _lactoseFreeFilterSet = isChecked;
              }),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),

            // Vegetarian filter tile
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) => setState(() {
                _vegetarianFilterSet = isChecked;
              }),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),

            // Vegan filter tile
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) => setState(() {
                _veganFilterSet = isChecked;
              }),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 24,
              ),
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
