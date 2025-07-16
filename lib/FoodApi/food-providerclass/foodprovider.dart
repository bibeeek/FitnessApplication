import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../DataModels/fooddata.dart';

class MealProvider with ChangeNotifier {
  final Map<String, List<MealEntry>> _meals = {
    'breakfast': [],
    'lunch': [],
    'dinner': [],
  };

  List<MealEntry> getMealEntries(String meal) => _meals[meal]!;

  void addFoodToMeal(String meal, MealEntry entry) {
    _meals[meal]!.add(entry);
    notifyListeners();
    saveMealsToPrefs();
  }

  void updateServing(String meal, int index, double newServing) {
    _meals[meal]![index].servingAmount = newServing;
    notifyListeners();
    saveMealsToPrefs();
  }

  void removeFoodFromMeal(String meal, int index) {
    if (_meals.containsKey(meal) && index >= 0 && index < _meals[meal]!.length) {
      _meals[meal]!.removeAt(index);
      notifyListeners();
      saveMealsToPrefs();
    }
  }
  void resetMeals() {
    _meals.updateAll((key, value) => []);
    notifyListeners();
  }

  void clearAllMeals() {
    _meals.updateAll((key, value) => []);
    notifyListeners();
    // saveMealsToPrefs();
  }

  // Calories calculation:
  double getMealCalories(String meal) {
    return _meals[meal]!.fold(0, (sum, entry) {
      return sum + (entry.food.caloriesPerServing / 100) * entry.servingAmount;
    });
  }

  // Total calories from all meals
  double get totalCalories {
    return _meals.values
        .expand((entries) => entries)
        .fold(0, (sum, entry) => sum + (entry.food.caloriesPerServing / 100) * entry.servingAmount);
  }

  // Total protein grams from all meals
  double get totalProtein {
    return _meals.values
        .expand((entries) => entries)
        .fold(0, (sum, entry) => sum + (entry.food.proteinPerServing / 100) * entry.servingAmount);
  }

  // Total carbs grams from all meals
  double get totalCarbs {
    return _meals.values
        .expand((entries) => entries)
        .fold(0, (sum, entry) => sum + (entry.food.carbsPerServing / 100) * entry.servingAmount);
  }

  // Total fat grams from all meals
  double get totalFat {
    return _meals.values
        .expand((entries) => entries)
        .fold(0, (sum, entry) => sum + (entry.food.fatPerServing / 100) * entry.servingAmount);
  }

  Future<void> saveMealsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final mealJson = _meals.map((meal, entries) => MapEntry(
        meal,
        jsonEncode(entries.map((e) => e.toJson()).toList())
    ));
    mealJson.forEach((key, value) {
      prefs.setString('meal_$key', value);
    });
  }

  Future<void> loadMealsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    for (var meal in _meals.keys) {
      final jsonString = prefs.getString('meal_$meal');
      if (jsonString != null) {
        final List<dynamic> decoded = jsonDecode(jsonString);
        _meals[meal] = decoded.map((e) => MealEntry.fromJson(e)).toList();
      }
    }
    notifyListeners();
  }

}
