import 'shopping_list_item_dto.dart';

class ShoppingListDto {
  final String name;
  final List<ShoppingListItemDto> items;

  ShoppingListDto({
    required this.name,
    required this.items,
  });

  factory ShoppingListDto.fromJson(Map<String, dynamic> json) {
    return ShoppingListDto(
      name: json['name'],
      items: (json['items'] as List)
          .map((item) => ShoppingListItemDto.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}