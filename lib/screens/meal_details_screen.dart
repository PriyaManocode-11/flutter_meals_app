import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/constants/strings.dart';
import 'package:meals_app/models/meals_model.dart';
import 'package:meals_app/provider/favaroiute_meal_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;

  Text headerText(BuildContext context, String text) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary));
  }

  contentText(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onSurface)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favarouiteMeal = ref.watch(favarouitesMealProvider);
    bool isFavarouite = favarouiteMeal.contains(meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              onPressed: () {
                final isAdded = ref
                    .read(favarouitesMealProvider.notifier)
                    .toggleFavaroiuteMeals(meal);
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(isAdded
                        ? 'Meals added to Favarouite'
                        : 'Meals is removed')));
              },
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween<double>(begin: 0.8, end: 1).animate(animation),
                      child: child,
                    );
                  },
                  child: Icon(isFavarouite ? Icons.star : Icons.star_border, key: ValueKey(isFavarouite),
                      size: 25)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(meal.imageUrl,
                  fit: BoxFit.cover, width: double.infinity, height: 300),
            ),
            const SizedBox(
              height: 10,
            ),
            headerText(context, Strings.ingridents),
            for (final ingredients in meal.ingredients)
              contentText(context, ingredients),
            const SizedBox(
              height: 10,
            ),
            headerText(context, Strings.steps),
            for (final steps in meal.steps) contentText(context, steps),
          ],
        ),
      ),
    );
  }
}
