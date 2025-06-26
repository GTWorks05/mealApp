import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/providers/filters_provider.dart';

// enum Filter { glutenFree, lactoseFree, vegan, vegetarian }

class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});

  // final Map<Filter, bool> currentFilters;

  //   @override
  //   ConsumerState<FilterScreen> createState() => _FilterScreenState();
  // }

  // class _FilterScreenState extends ConsumerState<FilterScreen> {
  // var _glutenFreeFilterSet = false;
  // var _lactoseFreeFilterSet = false;
  // var _veganFilterSet = false;
  // var _vegetarianFilterSet = false;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   final activeFilters = ref.read(filtersProvider);
  //   _glutenFreeFilterSet = activeFilters[Filter.glutenFree] ?? false;
  //   _lactoseFreeFilterSet = activeFilters[Filter.lactoseFree] ?? false;
  //   _veganFilterSet = activeFilters[Filter.vegan] ?? false;
  //   _vegetarianFilterSet = activeFilters[Filter.vegetarian] ?? false;
  // }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Your Filters')),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(
      //         context,
      //       ).push(MaterialPageRoute(builder: (ctx) => TabsScreen()));
      //     }
      //   },
      // ),
      body:
      // PopScope(
      //   canPop: false,
      //   onPopInvokedWithResult: (bool didPop, dynamic result) async {
      //     ref.read(filtersProvider.notifier).setFilters({
      //       Filter.glutenFree: _glutenFreeFilterSet,
      //       Filter.lactoseFree: _lactoseFreeFilterSet,
      //       Filter.vegan: _veganFilterSet,
      //       Filter.vegetarian: _vegetarianFilterSet,
      //     });
      //     if (didPop) return;
      //     Navigator.of(context).pop({});
      //   },
      //child:
      Column(
        children: [
          SwitchListTile(
            value: activeFilters[Filter.glutenFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, true);
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
            },
            title: const Text('Gluten-free', style: TextStyle(fontSize: 24)),
            subtitle: const Text('Only include gluten-free meals'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.lactoseFree]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, true);
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
            },
            title: const Text('Lactose-free', style: TextStyle(fontSize: 24)),
            subtitle: const Text('Only include lactose-free meals'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegan]!,
            onChanged: (isChecked) {
              ref.read(filtersProvider.notifier).setFilter(Filter.vegan, true);
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
            },
            title: const Text('Vegan', style: TextStyle(fontSize: 24)),
            subtitle: const Text('Only include vegan meals'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
          SwitchListTile(
            value: activeFilters[Filter.vegetarian]!,
            onChanged: (isChecked) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, true);
              // setState(() {
              //   _glutenFreeFilterSet = isChecked;
              // });
            },
            title: const Text('Vegetarian', style: TextStyle(fontSize: 24)),
            subtitle: const Text('Only include vegetarian meals'),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: const EdgeInsets.only(left: 34, right: 22),
          ),
        ],
      ),
    );
  }
}
