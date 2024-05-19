import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/enum/filter_enum.dart';
import 'package:meals_app/provider/meal_provider.dart';

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactosFree: false,
          Filter.veganFree: false,
          Filter.vegeterainFree: false
        });
  void setFilters(Map<Filter, bool> filtersData) {
    state = filtersData;
  }

  void setfilterMeals(Filter filter, bool isActive) {
    // state[filter] = isActive // not allowed to mutate state
    state = {...state, filter: isActive};
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
  (ref) {
    return FilterNotifier();
  },
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filterMeals = ref.watch(filterProvider);
  return meals.where((meal) {
      if (filterMeals[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filterMeals[Filter.lactosFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filterMeals[Filter.veganFree]! && !meal.isVegan) {
        return false;
      }
      if (filterMeals[Filter.vegeterainFree]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
},);