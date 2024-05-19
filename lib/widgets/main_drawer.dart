import 'package:flutter/material.dart';
import 'package:meals_app/constants/strings.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onTapScreen});

  final Function(String identifier) onTapScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Row(
                children: [
                  Icon(Icons.fastfood_sharp,
                      size: 45, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Cooking Up!..",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  )
                ],
              )),
            _bodyWidget(Icons.restaurant_rounded, Strings.meals, context, onTap: () {
              onTapScreen(Strings.meals);
            }),
            _bodyWidget(Icons.settings, Strings.filters, context, onTap: () {
              onTapScreen(Strings.filters);
            })    
        ],
      ),
    );
  }

  _bodyWidget(IconData icon, String title, BuildContext context, {Function()? onTap,}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.onBackground),
      title: Text(title ,style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 20)),
      onTap: onTap,
    );
  }
}
