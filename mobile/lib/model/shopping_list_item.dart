class ShoppingListItem {
  final String id;
  final String name;
  final bool completed;

  ShoppingListItem({
    required this.id,
    required this.name,
    required this.completed,
  });

  factory ShoppingListItem.fromJson(Map<String, dynamic> json) {
    return ShoppingListItem(
      id: json['id'],
      name: json['name'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'completed': completed,
    };
  }
}