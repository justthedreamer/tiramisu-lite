class ShoppingListItemDto {
  final String name;
  final bool completed;

  ShoppingListItemDto({
    required this.name,
    required this.completed,
  });

  factory ShoppingListItemDto.fromJson(Map<String, dynamic> json) {
    return ShoppingListItemDto(
      name: json['name'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'completed': completed,
    };
  }
}
