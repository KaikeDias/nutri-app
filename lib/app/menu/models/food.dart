class Food {
  final String id;
  final String name;
  final String quantity;
  final String unit;
  final String homeQuantity;
  final String homeUnit;
  final List<Food> substituitions;

  Food({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.homeQuantity,
    required this.homeUnit,
    this.substituitions = const [],
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      unit: json['unit'],
      homeQuantity: json['homeQuantity'],
      homeUnit: json['homeUnit'],
    );
  }
}
