import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/enum/filter_enum.dart';
import 'package:meals_app/provider/filter_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilter = ref.watch(filterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters ...')),
      body: Column(
        children: [
          _filterMeals(
              'Gluten-Free',
              'only include Gluten Free food',
              activeFilter[Filter.glutenFree]!,
              context, onChangeValue: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setfilterMeals(Filter.glutenFree, isChecked);
          }),
          _filterMeals(
              'Lactos-Free',
              'only include Lactos Free food',
              activeFilter[Filter.lactosFree]!,
              context, onChangeValue: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setfilterMeals(Filter.lactosFree, isChecked);
          }),
          _filterMeals(
              'Vegetarian-Free',
              'only include Vegetarian Free food',
              activeFilter[Filter.vegeterainFree]!,
              context, onChangeValue: (isChecked) {
            ref
                .read(filterProvider.notifier)
                .setfilterMeals(Filter.vegeterainFree, isChecked);
          }),
          _filterMeals(
            'Vegan-Free',
            'only include Vegan Free food',
            activeFilter[Filter.veganFree]!,
            context,
            onChangeValue: (isChecked) {
              ref
                  .read(filterProvider.notifier)
                  .setfilterMeals(Filter.veganFree, isChecked);
            },
          )
        ],
      ),
    );
  }

  _filterMeals(String title, String subTitle, bool value, BuildContext context,
      {Function(bool isChecked)? onChangeValue}) {
    return SwitchListTile(
      value: value,
      onChanged: onChangeValue,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
