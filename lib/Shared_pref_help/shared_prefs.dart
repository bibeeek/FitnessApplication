import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {

  static Future<void> saveUserInput({
    required String gender,
    required int age,
    required String goal,
    required String activityLevel,
    required double currentWeight,
    double? targetWeight, // nullable for maintain/fit etc.
    double? goalTime,         // nullable for maintain/fit etc.
    required double height,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('gender', gender);
    await prefs.setInt('age', age);
    await prefs.setString('goal', goal);
    await prefs.setString('activity', activityLevel);
    await prefs.setDouble('currentWeight', currentWeight);
    if (targetWeight != null) {
      await prefs.setDouble('targetWeight', targetWeight);
    }
    if (goalTime != null) {
      await prefs.setDouble('goalTime', goalTime);
    }
    await prefs.setDouble('height', height);

    await prefs.setBool('hasCompletedInput', true);
  }

  static Future<bool> hasCompletedInput() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('hasCompletedInput') ?? false;
  }

  static Future<Map<String, dynamic>> loadUserInput() async {
    final prefs = await SharedPreferences.getInstance();
    return {

      'gender': prefs.getString('gender'),
      'age': prefs.getInt('age'),
      'goal': prefs.getString('goal'),
      'activity': prefs.getString('activity'),
      'currentWeight': prefs.getDouble('currentWeight'),
      'targetWeight': prefs.getDouble('targetWeight'),
      'goalTime': prefs.getInt('goalTime'),
      'height': prefs.getDouble('height'),
    };
  }

  static Future<bool> hasUserData() async {
    final prefs = await SharedPreferences.getInstance();


    bool hasAllKeys = prefs.containsKey('gender') &&
        prefs.containsKey('age') &&
        prefs.containsKey('goal') &&
        prefs.containsKey('activity') &&
        prefs.containsKey('currentWeight') &&
        prefs.containsKey('height');


    return hasAllKeys;
  }

}
