import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../FoodApi/food-providerclass/foodprovider.dart';  // Your MealProvider
import '../FoodApi/DataModels/fooddata.dart';

class FoodLogPage extends StatelessWidget {
  const FoodLogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);

    // List of meal keys
    final meals = ['breakfast', 'lunch', 'dinner'];

    return Scaffold(

      backgroundColor: Colors.blueGrey[50],

      appBar: AppBar(
        title: Text('Food Log'),
        automaticallyImplyLeading: false,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        centerTitle: true,
        backgroundColor:  Color.fromRGBO(0, 130, 83, 1),
      ),
      body: ListView.builder(
        itemCount: meals.length,
        itemBuilder: (context, index) {
          final meal = meals[index];
          final entries = mealProvider.getMealEntries(meal);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(meal[0].toUpperCase() + meal.substring(1),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color:  Color.fromRGBO(0, 130, 83, 1), width: 2),
              ),

              children: entries.isEmpty
                  ? [ListTile(title: Text('No food added'))]
                  : List.generate(entries.length, (i) {
                final entry = entries[i];
                return ListTile(
                  title: Text(entry.food.name),
                  subtitle: Text(
                    '${entry.servingAmount} ${entry.food.servingUnit} - ${entry.calories.toStringAsFixed(1)} kcal',
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.black),
                    onPressed: () {
                      mealProvider.removeFoodFromMeal(meal, i);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed "${entry.food.name}" from $meal'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Show nutritional info
                    final info =
                        '${entry.food.name}\n\n'
                        'Protein: ${(entry.food.proteinPerServing * entry.servingAmount / 100).toStringAsFixed(1)} g\n'
                        'Fat: ${(entry.food.fatPerServing * entry.servingAmount / 100).toStringAsFixed(1)} g\n'
                        'Carbs: ${(entry.food.carbsPerServing * entry.servingAmount / 100).toStringAsFixed(1)} g';

                    ScaffoldMessenger.of(context).showSnackBar(

                      SnackBar(
                        backgroundColor: Colors.blueGrey[50],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        content: Text(info,style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),

                        duration: Duration(milliseconds: 2000),
                      ),
                    );
                  },
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
