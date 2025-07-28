import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepProvider extends ChangeNotifier {
  int _stepsToday = 0;
  int _initialSteps = 0;
  DateTime? _lastSavedDate;

  int get stepsToday => _stepsToday;
  final int dailyGoal = 10000;

  double get progress => (_stepsToday / dailyGoal).clamp(0, 1);
  String get percentageText => '${(_stepsToday / dailyGoal * 100).clamp(0, 100).toStringAsFixed(0)}% of $dailyGoal steps goal';

  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    _initialSteps = prefs.getInt('step_counter_initial_steps') ?? 0;

    String? dateString = prefs.getString('step_counter_last_date');
    if (dateString != null) {
      _lastSavedDate = DateTime.tryParse(dateString);
    }

    DateTime today = DateTime.now();
    if (_lastSavedDate == null ||
        _lastSavedDate!.year != today.year ||
        _lastSavedDate!.month != today.month ||
        _lastSavedDate!.day != today.day) {
      _initialSteps = 0;
      _lastSavedDate = today;
      await prefs.setInt('step_counter_initial_steps', 0);
      await prefs.setString('step_counter_last_date', today.toIso8601String());
    }
  }

  Future<void> updateSteps(int rawSteps) async {
    if (_initialSteps == 0) {
      _initialSteps = rawSteps;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('step_counter_initial_steps', _initialSteps);
      await prefs.setString('step_counter_last_date', DateTime.now().toIso8601String());
    }

    _stepsToday = rawSteps - _initialSteps;
    if (_stepsToday < 0) _stepsToday = 0;
    notifyListeners();
  }

  void resetSteps() {
    _stepsToday = 0;
    _initialSteps = 0;
    notifyListeners();
  }
}
