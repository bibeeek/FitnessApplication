class MacroCalculator {
  static Map<String, double> calculateRequiredMacros({
    required String goal, // "gain", "lose", "maintain"
    required double bodyWeightKg,
  }) {
    double protein = 0, carbs = 0, fat = 0;

    switch (goal.toLowerCase()) {
      case 'gain':
        protein = 1.8 * bodyWeightKg;
        carbs = 4.0 * bodyWeightKg;    // example carb for gain
        fat = 0.9 * bodyWeightKg;      // example fat for gain
        break;
      case 'lose':
        protein = 1.5 * bodyWeightKg;
        carbs = 2.5 * bodyWeightKg;    // less carbs for cut
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
