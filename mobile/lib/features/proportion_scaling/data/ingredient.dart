class Ingredient {
  final String name;
  final double amount;
  final String unit;

  Ingredient({
    required this.name,
    required this.amount,
    required this.unit,
  });

  Ingredient copyWith({String? name, double? amount, String? unit}) {
    return Ingredient(
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
    );
  }
}