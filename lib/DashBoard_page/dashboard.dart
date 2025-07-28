import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitnessapp/STEPCOUNTER/stepcounter.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Calorie_Calculator/calorie_calc_logic.dart';
import '../FirstPage/First_AppPage.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';
import '../LoginRegs/LoginPage.dart';
import '../provider_classes/Inputs_provider/Genderselection_provider.dart';
import '../provider_classes/Inputs_provider/activitylevel_provider.dart';
import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';
import '../provider_classes/Inputs_provider/healthdataprovider.dart';
import 'FoodLogginPagee.dart';

class MacroCalculator {
  static Map<String, double> calculateRequiredMacros({
    required String goal,
    required double bodyWeightKg,
  }) {
    double protein = 0, carbs = 0, fat = 0;

    switch (goal.toLowerCase()) {
      case 'gain':
        protein = 1.8 * bodyWeightKg;
        carbs = 4.0 * bodyWeightKg;
        fat = 0.9 * bodyWeightKg;
        break;
      case 'lose':
        protein = 1.5 * bodyWeightKg;
        carbs = 2.5 * bodyWeightKg;
        fat = 0.8 * bodyWeightKg;
        break;
      case 'maintain':
      default:
        protein = 1.6 * bodyWeightKg;
        carbs = 3.0 * bodyWeightKg;
        fat = 0.85 * bodyWeightKg;
        break;
    }

    return {
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    final inputProvider = Provider.of<AllInputsProvider>(context);
    final goalProvider = Provider.of<GoalSelectionProvider>(context);
    final activityProvider = Provider.of<ActivityLevelProvider>(context);
    final genderProv = Provider.of<genderProvider>(context);

    double reqCal = calculateDailyCalories(
      sex: genderProv.getGender.toString(),
      age: inputProvider.getSelectedAge,
      height: inputProvider.getCurrentHeight,
      currentWeight: inputProvider.getCurrentWeight,
      activityLevel: activityProvider.getSelectedLevel.toString(),
      goal: goalProvider.getSelectedGoal.toString(),
      targetWeight: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
          ? inputProvider.getTargetWeight
          : null,
      goalAchieveTime: goalProvider.getSelectedGoal == 'gain' || goalProvider.getSelectedGoal == 'lose'
          ? inputProvider.getGoalAchieveTime
          : null,
    );

    return WillPopScope(
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Exit App"),
            content: Text("Do you really want to exit the app?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text("No"),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text("Yes"),
              ),
            ],
          ),
        );
        return shouldExit;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          backgroundColor: Color.fromRGBO(0, 130, 83, 1),
          elevation: 0,
          title: const Text("Today's Goal", style: TextStyle(fontSize: 22,color: Colors.white, fontWeight: FontWeight.bold)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_today_outlined,color: Colors.white,)),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Track Food Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.restaurant_menu, color: Colors.green),
                        SizedBox(width: 20),
                        Text('Track Food', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Spacer(),
                        IconButton(onPressed: () {}, icon: const Icon(Iconsax.camera)),
                        IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined, color: Colors.green)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Consumer<MealProvider>(
                      builder: (context, mealProvider, _) {
                        final totalCalories = mealProvider.totalCalories;
                        final percentage = ((totalCalories / reqCal) * 100).clamp(0, 100);
                        final overLimit = totalCalories > reqCal;

                        return Row(
                          children: [
                            CircularPercentage(
                              currentPercentage: percentage.toDouble(),
                              maxPercentage: 100,
                              percentageStrokeWidth: 3,
                              backgroundStrokeWidth: 2,
                              backgroundColor: Colors.grey,
                              percentageColor: overLimit ? Colors.redAccent.shade100 : Colors.green,
                              centerText:
                              "${totalCalories.toStringAsFixed(0)} / ${reqCal.toStringAsFixed(0)}",
                              centerTextStyle:
                              TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 25),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Your Goal",style: TextStyle(
                                  color: overLimit ? Colors.redAccent.shade100 : Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),),
                                Text(
                                  '${reqCal.toStringAsFixed(0)} kcal',
                                  style: TextStyle(
                                    color: overLimit ? Colors.redAccent.shade100 : Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Consumer<MealProvider>(
                      builder: (context, mealProvider, _) {
                        final totalCalories = mealProvider.totalCalories;
                        final totalProtein = mealProvider.totalProtein;
                        final totalCarbs = mealProvider.totalCarbs;
                        final totalFat = mealProvider.totalFat;

                        final bodyWeight = inputProvider.getCurrentWeight;
                        final goal = goalProvider.getSelectedGoal;

                        final requiredMacros = MacroCalculator.calculateRequiredMacros(
                          goal: goal.toString(),
                          bodyWeightKg: bodyWeight,
                        );

                        final reqProtein = requiredMacros['protein']!;
                        final reqCarbs = requiredMacros['carbs']!;
                        final reqFat = requiredMacros['fat']!;

                        double calPercent = (totalCalories / reqCal).clamp(0, 1);
                        double proteinPercent = (totalProtein / reqProtein).clamp(0, 1);
                        double carbPercent = (totalCarbs / reqCarbs).clamp(0, 1);
                        double fatPercent = (totalFat / reqFat).clamp(0, 1);

                        Color calColor = totalCalories > reqCal ? Colors.redAccent : Colors.green;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,


                                children: [

                                  Text(
                                    'Calories: ${totalCalories.toStringAsFixed(0)} / ${reqCal.toStringAsFixed(0)} kcal',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5,),
                                  SizedBox(
                                    width:150,
                                    child: LinearProgressIndicator(
                                      value: calPercent,
                                      color: calColor,
                                      backgroundColor: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Protein: ${totalProtein.toStringAsFixed(1)} g / ${reqProtein.toStringAsFixed(1)} g',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5,),

                                  SizedBox(
                                    width:150,
                                    child: LinearProgressIndicator(
                                      value: proteinPercent,
                                      color: proteinPercent >= 1 ? Colors.red : Colors.blue,
                                      backgroundColor: Colors.grey.shade300,
                                    ),
                                  ),
                                ],
                              ),

                            ],),


                            SizedBox(height: 8),


                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Carbs: ${totalCarbs.toStringAsFixed(1)} g / ${reqCarbs.toStringAsFixed(1)} g',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: LinearProgressIndicator(
                                        value: carbPercent,
                                        color: carbPercent >= 1 ? Colors.red : Colors.orange,
                                        backgroundColor: Colors.grey.shade300,
                                      ),
                                    ),
                                  ],
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Fat: ${totalFat.toStringAsFixed(1)}  g  / ${reqFat.toStringAsFixed(1)}  g',
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width:150,
                                      child: LinearProgressIndicator(
                                        value: fatPercent,
                                        color: fatPercent >= 1 ? Colors.red : Colors.yellow,
                                        backgroundColor: Colors.grey.shade300,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                          ],

                        );
                      },
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 7),


              Consumer<HealthLevelProvider>(
                builder: (context, provider, _) {
                  final int goal = 3500; // or set based on gender
                  final int current = provider.waterIntake;
                  final double progress = (current / goal).clamp(0, 1);

                  return Container(

                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("💧 Water Intake", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        LinearProgressIndicator(
                          value: progress,
                          minHeight: 8,
                          backgroundColor: Colors.blue.shade100,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                        SizedBox(height: 8),
                        Text("$current ml / $goal ml"),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                provider.incrementWaterIntake(250); // Add 250ml
                              },
                              icon: Icon(Icons.add,color: Colors.white,),
                              label: Text("Add 250ml",style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                if (provider.waterIntake >= 250) {
                                  provider.incrementWaterIntake(-250); // Subtract 250ml
                                }
                              },
                              icon: Icon(Icons.remove,color: Colors.white,),
                              label: Text("Remove 250ml",style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 7,),
              StepCounterWidget()



            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                padding: EdgeInsets.all(10),
                duration: Duration(seconds: 3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text("BreakFast"),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FoodSearchPage(meal: 'breakfast')));
                        },
                        icon: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Text("Lunch"),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FoodSearchPage(meal: 'lunch')));
                        },
                        icon: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                    ListTile(
                      title: Text("Dinner"),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FoodSearchPage(meal: 'dinner')));
                        },
                        icon: Icon(Icons.add, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
