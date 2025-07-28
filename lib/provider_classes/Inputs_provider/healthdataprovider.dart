import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HealthLevelProvider with ChangeNotifier{
  int _waterIntake = 0; // in ml or glasses

  int get waterIntake => _waterIntake;

  void incrementWaterIntake(int amount) {
    _waterIntake += amount;
    notifyListeners();
    saveWaterToPrefs(); // persist
  }

  void resetWaterIntake() {
    _waterIntake = 0;
    notifyListeners();
    saveWaterToPrefs();
  }

  void setWaterIntake(int amount) {
    _waterIntake = amount;
    notifyListeners();
  }

// Save to SharedPreferences
  Future<void> saveWaterToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('waterIntake', _waterIntake);
  }

// Load from SharedPreferences
  Future<void> loadWaterFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _waterIntake = prefs.getInt('waterIntake') ?? 0;
    notifyListeners();
  }

}
