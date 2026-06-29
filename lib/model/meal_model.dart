class Meal {
  final String name;
  final int calories;

  Meal({required this.name, required this.calories});

  Meal copyWith({String? name, int? calories}) {
    return Meal(
      name: name ?? this.name,
      calories: calories ?? this.calories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'calories': calories,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      name: map['name'] ?? '',
      calories: map['calories'] ?? 0,
    );
  }
}
