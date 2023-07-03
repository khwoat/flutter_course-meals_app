import 'package:flutter/material.dart';

enum DrawerMenuIdentifier {
  meals,
  filters,
}

/// Main Drawer that contains short-cut menu such as filtering.
class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
    required this.onSelectMenu,
  });

  final void Function(DrawerMenuIdentifier identifier) onSelectMenu;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Header
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 14),
                Text(
                  'Cooking Time!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),

          // Close drawer button
          ListTile(
            onTap: () => onSelectMenu(DrawerMenuIdentifier.meals),
            leading: const Icon(
              Icons.restaurant,
            ),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),

          // Filter button
          ListTile(
            onTap: () => onSelectMenu(DrawerMenuIdentifier.filters),
            leading: const Icon(
              Icons.sort,
            ),
            title: Text(
              'Filters',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
