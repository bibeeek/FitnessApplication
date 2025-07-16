import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
import '../provider_classes/Inputs_provider/goal_level_provider.dart';
import '../provider_classes/Inputs_provider/activitylevel_provider.dart';
import '../provider_classes/Inputs_provider/Genderselection_provider.dart';

Future<void> loadSavedDataIntoProviders(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();

  final inputProvider = Provider.of<AllInputsProvider>(context, listen: false);
  final goalProvider = Provider.of<GoalSelectionProvider>(context, listen: false);
  final activityProvider = Provider.of<ActivityLevelProvider>(context, listen: false);
  final genderProviderInstance = Provider.of<genderProvider>(context, listen: false);

  // Set values to providers from SharedPreferences
  final genderString = prefs.getString('gender');
  if (genderString != null) {
    genderProviderInstance.setGender(Gender.values.firstWhere(
          (e) => e.name == genderString,
      orElse: () => Gender.Male, // fallback
    ));
  }
  inputProvider.setSelectedAge(prefs.getInt('age') ?? 18);
  goalProvider.setSelectedGoal(prefs.getString('goal') ?? '');
  activityProvider.setSelectedLevel(prefs.getString('activity') ?? '');
  inputProvider.setCurrentWeight(prefs.getDouble('currentWeight') ?? 60.0);

  final targetWeight = prefs.getDouble('targetWeight');
  if (targetWeight != null) {
    inputProvider.setTargetWeight(targetWeight);
  }

  final goalTime = prefs.getDouble('goalTime');
  if (goalTime != null) {
    inputProvider.setGoalAchieveTime(goalTime.toDouble());
  }

  final height = prefs.getDouble('height');
  if (height != null) {
    inputProvider.setSelectedHeight(height);
  }
}
