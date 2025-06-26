import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealapp/data/dummy_data.dart';
import 'package:mealapp/providers/favorites_provider.dart';
import 'package:mealapp/providers/filters_provider.dart';
import 'package:mealapp/providers/meals_provider.dart';
import 'package:mealapp/screens/categories.dart';
import 'package:mealapp/screens/filters.dart';
import 'package:mealapp/screens/meals.dart';
import 'package:mealapp/widgets/main_drawer.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  //final Map<Filter,bool>currentFilters;

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  //final List<Meal> _favoriteMeals = [];

  //Map<Filter, bool> _selectedFilters = kInitialFilters;
  // {
  //   Filter.glutenFree: false,
  //   Filter.lactoseFree: false,
  //   Filter.vegan: false,
  //   Filter.vegetarian: false,
  // };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  // void _toggleMealFavoriteStatus(Meal meal) {
  //   final isExisting = _favoriteMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     });
  //     _showInfoMessage('Meal removed from favorites!');
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //       _showInfoMessage('Meal added to favorites!');
  //     });
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activefilters = ref.watch(filtersProvider);
    final availableMeals =
        dummyMeals.where((meal) {
          if (activefilters[Filter.glutenFree] == true && !meal.isGlutenFree) {
            return false;
          }
          if (activefilters[Filter.lactoseFree] == true &&
              !meal.isLactoseFree) {
            return false;
          }
          if (activefilters[Filter.vegan] == true && !meal.isVegan) {
            return false;
          }
          if (activefilters[Filter.vegetarian] == true && !meal.isVegetarian) {
            return false;
          }
          return true;
        }).toList();

    Widget activePage = CategoriesScreen(
      //onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final fMeal = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: fMeal,
        //onToggleFavrite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favourites';
    }
    void setScreen(String identifier) async {
      if (identifier == 'filters') {
        Navigator.of(context).pop();
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => FilterScreen()),
        );
        print(result);
        setState(() {
          //_selectedFilters = result ?? kInitialFilters;
        });
      } else {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      drawer: MainDrawer(onSelectScreen: setScreen),
      body: activePage,

      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.category),
            label: 'Categories',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.star),
            label: 'Favorites',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
