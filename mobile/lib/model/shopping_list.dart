import 'package:mobile/model/shopping_list_item.dart';

class ShoppingList {
  final String id;
  final String name;
  final List<ShoppingListItem> items;
  final DateTime createdAt;

  ShoppingList({
    required this.id,
    required this.name,
    required this.items,
    required this.createdAt,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      items:
          (json['items'] as List)
              .map((item) => ShoppingListItem.fromJson(item))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  ShoppingList copyWith({
    String? id,
    String? name,
    List<ShoppingListItem>? items,
    DateTime? createdAt,
  }) {
    return ShoppingList(
      id: id ?? this.id,
      name: name ?? this.name,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
