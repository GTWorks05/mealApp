import 'package:flutter/material.dart';
import 'package:mealapp/models/meal.dart';
import 'package:mealapp/screens/meal_details.dart';
import 'package:mealapp/widgets/mean_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    //required this.onToggleFavrite,
  });
  final String? title;
  final List<Meal> meals;
  //final void Function(Meal meal) onToggleFavrite;

  //void Function(Meal meal) onSelectMeal;

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder:
            (ctx) => MealDetailsScreen(
              meal: meal,
              //ontoggleFavorite: onToggleFavrite,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Uh oh! No meals found.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder:
            (ctx, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (context, meal) {
                selectMeal(context, meal);
              },
            ),
      );
    }

    if (title == null) {
      return content;
    }
    return Scaffold(
      //title: const Text('Meals'),
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
