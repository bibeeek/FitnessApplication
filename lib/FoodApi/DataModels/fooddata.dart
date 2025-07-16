class FoodItem {
  final String id;
  final String name;
  final double caloriesPerServing;
  final double proteinPerServing;
  final double fatPerServing;
  final double carbsPerServing;
  final String servingUnit; // e.g. "g" or "piece"

  FoodItem({
    required this.id,
    required this.name,
    required this.caloriesPerServing,
    required this.proteinPerServing,
    required this.fatPerServing,
    required this.carbsPerServing,
    required this.servingUnit,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'calories': caloriesPerServing,
    'protein': proteinPerServing,
    'fat': fatPerServing,
    'carbs': carbsPerServing,
    'unit': servingUnit,
  };

  factory FoodItem.fromJson(Map<String, dynamic> json) => FoodItem(
    id: json['id'],
    name: json['name'],
    caloriesPerServing: (json['calories'] as num).toDouble(),
    proteinPerServing: (json['protein'] as num).toDouble(),
    fatPerServing: (json['fat'] as num).toDouble(),
    carbsPerServing: (json['carbs'] as num).toDouble(),
    servingUnit: json['unit'],
  );
}

class MealEntry {
  final FoodItem food;
  double servingAmount; // user input

  MealEntry({required this.food, required this.servingAmount});
  double get calories => (food.caloriesPerServing / 100) * servingAmount;

  Map<String, dynamic> toJson() => {
    'food': food.toJson(),
    'servingAmount': servingAmount,
  };

  factory MealEntry.fromJson(Map<String, dynamic> json) => MealEntry(
    food: FoodItem.fromJson(json['food']),
    servingAmount: (json['servingAmount'] as num).toDouble(),

  );
}
