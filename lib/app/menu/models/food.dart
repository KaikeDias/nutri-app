class Food {
  final String name;
  final String quantity;
  final List<Food> substituitions;

  Food({
    required this.name,
    required this.quantity,
    this.substituitions = const [],
  });
}
