class FoodItem {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double servingSize;
  final DateTime timestamp;

  FoodItem({
    required this.name,
    required this.calories,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.servingSize = 100,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'servingSize': servingSize,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      calories: json['calories'].toDouble(),
      protein: json['protein']?.toDouble() ?? 0,
      carbs: json['carbs']?.toDouble() ?? 0,
      fat: json['fat']?.toDouble() ?? 0,
      servingSize: json['servingSize']?.toDouble() ?? 100,
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}