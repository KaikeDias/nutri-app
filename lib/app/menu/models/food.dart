class Food {
  final String id;
  final String name;
  final String quantity;
  final String unit;
  final List<Food> substituitions;

  Food({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    this.substituitions = const [],
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }
}
