import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/constants/strings.dart';
import 'package:meals_app/enum/filter_enum.dart';
import 'package:meals_app/provider/favaroiute_meal_provider.dart';
import 'package:meals_app/provider/filter_provider.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kIntialFilter = {
  Filter.glutenFree: false,
  Filter.lactosFree: false,
  Filter.veganFree: false,
  Filter.vegeterainFree: false
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedIndex = 0;
  void _selectScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapListItems(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == Strings.filters) {
       await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const FiltersScreen(),
      ));
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeal = ref.watch(filteredMealsProvider);
    Widget activePage = CategoriesScreen(availableMeal: availableMeal);
    String activePageTitle = Strings.catagories;

    if (_selectedIndex == 1) {
      final favarouiteMeal = ref.watch(favarouitesMealProvider);
      activePage = MealsScreen(meals: favarouiteMeal);
      activePageTitle = Strings.yourFavaroties;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onTapScreen: _onTapListItems),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: Strings.catagories),
          BottomNavigationBarItem(
              icon: Icon(Icons.star), label: Strings.favourites)
        ],
      ),
    );
  }
}
