import 'package:mobile/model/dto/shopping_list_item_dto.dart';

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
      id: json['id'] as String,
      name: json['name'] as String,
      completed: json['completed'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'completed': completed};
  }

  ShoppingListItem copyWith({String? id, String? name, bool? completed}) {
    return ShoppingListItem(
      id: id ?? this.id,
      name: name ?? this.name,
      completed: completed ?? this.completed,
    );
  }

  ShoppingListItemDto toDto() =>
      ShoppingListItemDto(name: name, completed: completed);
}
