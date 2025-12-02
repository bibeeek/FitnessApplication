double calculateDailyCalories({
  required String sex,
  required int age,
  required double height,
  required double currentWeight,
  required String activityLevel,
  required String goal,
  double? targetWeight,
  double?
  goalAchieveTime,
}) {
  // Step 1: Calculate BMR
  double bmr;
  if (sex == 'Gender.Male') {
    bmr = (10 * currentWeight) + (6.25 * height) - (5 * age) + 5;
  } else {
    bmr = (10 * currentWeight) + (6.25 * height) - (5 * age) - 161;
  }

  // Step 2: Determine activity factor
  double activityFactor;
  switch (activityLevel.toLowerCase()) {
    case 'very':
      activityFactor = 1.8;
      break;
    case 'moderate':
      activityFactor = 1.55;
      break;
    case 'light':
      activityFactor = 1.375;
      break;
    case 'sedentary':
    default:
      activityFactor = 1.2;
      break;
  }
  // Step 3: Calculate TDEE
  double tdee = bmr * activityFactor;

  // Step 4: Calculate daily calorie adjustment based on weekly weight change goal
  if ((goal == 'gain' || goal == 'lose') &&
      goalAchieveTime != null &&
      goalAchieveTime > 0) {

    double dailyCalorieChange = (goalAchieveTime * 7700) / 7;

    double adjustedCalories =
        (goal == 'gain')
            ? tdee + dailyCalorieChange
            : tdee - dailyCalorieChange;

    if (adjustedCalories < 1000) adjustedCalories = 1500;
    return adjustedCalories;
  }
  // If maintain or no goalAchieveTime, just return TDEE
  return tdee;
}
