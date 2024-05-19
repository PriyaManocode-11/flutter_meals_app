import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meals_model.dart';

class FavarouitesMealNotifier extends StateNotifier<List<Meal>> {
  FavarouitesMealNotifier() : super([]);

  bool toggleFavaroiuteMeals(Meal meal) {
    final mealsIsFavaroiute = state.contains(meal);
    if (mealsIsFavaroiute) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favarouitesMealProvider =
    StateNotifierProvider<FavarouitesMealNotifier, List<Meal>>(
  (ref) {
    return FavarouitesMealNotifier();
  },
);
